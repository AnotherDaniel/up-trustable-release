#!/bin/bash

# Copyright (C) 2025 Eclipse Foundation and others. 
# 
# This program and the accompanying materials are made available under the
# terms of the Eclipse Public License v. 2.0 which is available at
# http://www.eclipse.org/legal/epl-2.0.
# 
# SPDX-FileType: SOURCE
# SPDX-FileCopyrightText: 2025 Eclipse Foundation
# SPDX-License-Identifier: EPL-2.0

source lib/logging.sh

CURRENT_LOG_LEVEL=${LOG_LEVEL:-${LOG_LEVEL_DEBUG}}
LOG_TIMESTAMP=${LOG_TIMESTAMP:-"off"}

WORKSPACE_DIR="/up-trustable-release"
ASSET_LOCATION="${WORKSPACE_DIR}/release_artifacts"
EVIDENCE_LOCATION="${WORKSPACE_DIR}/release_evidence"

TSF_TOOL="trudag"

print_help() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -t                Enable logging timestamps"
  echo "  -v                Increase verbosity level"
  echo "  -w <directory>    Set the workspace directory"
  echo "  --cleanup         Clean up assertion and evidence locations"
  echo "  --help            Display this help message"
}

main() {
  # Parse command line arguments
  while getopts "vtw:-:" opt; do
    case ${opt} in
      t)
        LOG_TIMESTAMP="on"
        ;;
      v)
        ((CURRENT_LOG_LEVEL++))
        ;;
      w)
        WORKSPACE_DIR="${OPTARG}"
        ASSET_LOCATION="${WORKSPACE_DIR}/release_artifacts"
        EVIDENCE_LOCATION="${WORKSPACE_DIR}/release_evidence"
        ;;
      -)
        case "${OPTARG}" in
          cleanup)
            cleanup
            exit 0
            ;;
          help)
            print_help
            exit 0
            ;;
          *)
            echo "Invalid option: --${OPTARG}" >&2
            print_help
            exit 1
            ;;
        esac
        ;;
      *)
        print_help
        exit 1
        ;;
    esac
  done

  # Check if doorstop binary is available
  if ! command -v ${TSF_TOOL} &> /dev/null; then
    log_error "${TSF_TOOL} binary could not be found. Exiting."
    exit 1
  fi

  # Check if ASSET_LOCATION exists
  if [[ ! -d "${ASSET_LOCATION}" ]]; then
    log_error "ASSET_LOCATION does not exist: ${ASSET_LOCATION}. Exiting."
    exit 1
  fi

  # Make sure EVIDENCE_LOCATION exists
  if [[ ! -d "${EVIDENCE_LOCATION}" ]]; then
    log_debug "EVIDENCE_LOCATION does not exist: ${EVIDENCE_LOCATION}. Creating..."
    mkdir -p ${EVIDENCE_LOCATION}
  fi

  # Loop through each subdirectory in ASSET_LOCATION and process
  for dir in "${ASSET_LOCATION}"/*/; do
    if [[ -d "${dir}" ]]; then
      log_info "Processing subdirectory: ${dir}"
      process_assetdir "${dir}"
    fi
  done
}

cleanup() {
  log_info "Cleaning up assertion and evidence locations"
  # Ensure that doorstop metadata is not deleted during cleanup
  find "${EVIDENCE_LOCATION}" -mindepth 1 ! -name '.doorstop.yml' -delete
  log_info "Cleanup completed"
}

process_assetdir() {
  local subdir_path=$1

  # Extract the last component of the path
  local component
  component=$(basename "${subdir_path}")

  # Iterate over all .tsffer files in the subdirectory
  find "${subdir_path}" -type f -name "*.tsffer" | while read -r tsffer_file; do
    log_info "Processing tsffer file: ${tsffer_file}"

    # Extract information from the .tsffer file
    local github_workflow
    github_workflow=$(jq -r '.["context-info"]["by-workflow"]' "${tsffer_file}")
    local github_ref
    github_ref=$(jq -r '.["context-info"]["ref"]' "${tsffer_file}")

    # General fields
    local asset_name
    asset_name=$(jq -r '.["asset-info"]["name"]' "${tsffer_file}")
    local asset_description
    asset_description=$(jq -r '.["asset-info"]["description"]' "${tsffer_file}")
    local asset_type
    asset_type=$(jq -r '.["asset-info"]["type"]' "${tsffer_file}")

    # for file-type assets, extract download-url
    local asset_url
    asset_url=$(jq -r '.["asset-info"]["download-url"] // empty' "${tsffer_file}")

    # for reference-type assets, extract evidence links
    declare -a evidence_links=()
    if [[ -z "${asset_url}" ]]; then
      log_debug "Extracting evidence links..."
      mapfile -t evidence_links < <(jq -r '.["asset-info"]["evidence-links"][]' "${tsffer_file}")
      log_debug "Found ${#evidence_links[@]} evidence links"
      for link in "${evidence_links[@]}"; do
          log_debug "Evidence link: ${link}"
      done
    fi

    # Generate evidence text body
    log_info "Generating evidence text: ${asset_name}"
    local text
    text=$(evidence_text "${component}" "${asset_name}" "${asset_description}" "${asset_type}" "${asset_url}" "${asset_checksum}" evidence_links "${github_workflow}" "${github_ref}")

    # create evidence file
    log_info "Creating evidence item: ${asset_name}"
    local evidence_item
    evidence_item=$(create_evidence "${component}" "${asset_name}" "${asset_type}" "${text}")

    # link up evidence file with any TSF ids referenced by manifest
    jq -r '.["asset-info"]["tsf-ids"][]' "${tsffer_file}" | while read -r tsf_id; do
      log_info "Linking evidence '${evidence_item}' to TSF ID: ${tsf_id}"
      link_evidence "${evidence_item}" "${tsf_id}"
    done
  done
}

evidence_text() {
  local component=$1
  local asset_name=$2
  local asset_description=$3
  local asset_type=$4
  local asset_url=$5
  local asset_checksum=$6
  local -n evidence_refs=$7
  local github_workflow=$8
  local github_ref=$9

  # Construct the evidence string
  local evidence_string
  evidence_string+="Component ${component} has an associated quality asset '${asset_name}' with the following properties:"$'\n'
  evidence_string+=$'\n'"- asset origin: workflow '${github_workflow}', initiated by github ref '${github_ref}'"

  # We should either see download-url evidence, pointing to specific files that are e.g. part of a release...
  if [[ -n "${asset_url}" ]]; then
    evidence_string+=$'\n'"- asset location: ${asset_url}"
    evidence_string+=$'\n'"- sha-256 checksum: ${asset_checksum}"
  fi

  # ... or (one or more) references/links to e.g. repository files, project websites, etc
  if (( ${#evidence_refs[@]} > 0 )); then
    evidence_string+=$'\n'"- link(s) to evidence:"

    for link in "${evidence_refs[@]}"; do
      evidence_string+=$'\n'"    ${link}"
    done
  fi

  if [[ -n "${asset_type}" ]]; then
    evidence_string+=$'\n'"- asset type: ${asset_type}"
  fi
  if [[ -n "${asset_description}" ]]; then
    evidence_string+=$'\n'"- asset description: ${asset_description}"
  fi

  echo "${evidence_string}"
}

# Create evidence item
create_evidence() {
  local component=$1
  local asset_name=$2
  local asset_type=$3
  local evidence_text=$4

  # Ensure that there is a place for our new evidence item
  if [[ ! -d "${EVIDENCE_LOCATION}/${component}" ]]; then
    mkdir -p "${EVIDENCE_LOCATION}/${component}"
  fi

  if ! "${TSF_TOOL}" manage create-item ${asset_type} ${asset_name} ${EVIDENCE_LOCATION}/${component} 2>&1; then
    log_error "Failed to add evidence using ${TSF_TOOL}"
    return 1
  fi

  local filename
  filename="${EVIDENCE_LOCATION}/${component}/$(to_upper "${asset_type}")-$(to_upper "${asset_name}").md"
  echo "${evidence_text}" >> "${filename}"
  log_debug "Created evidence item at ${filename}"

  # Return name of newly create evidence component
  echo "$(to_upper "${asset_type}")-$(to_upper "${asset_name}")"
}

link_evidence() {
  local child_statement=$1
  local parent_statement=$2

  if ! "${TSF_TOOL}" manage create-link ${parent_statement} ${child_statement} 2>&1; then
    log_error "Failed to link evidence using ${TSF_TOOL}"
    return 1
  fi

  log_info "Linked ${child_statement} to ${parent_statement}"
}

to_upper() {
    local str="$1"
    echo "${str^^}"
}

main "$@"