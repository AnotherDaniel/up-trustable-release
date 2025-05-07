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

ASSERTION_LOCATION="${WORKSPACE_DIR}/trustable/uProtocol/gen_assertions"
EVIDENCE_LOCATION="${WORKSPACE_DIR}/trustable/uProtocol/gen_evidence"

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
  if ! command -v doorstop &> /dev/null; then
    log_error "doorstop binary could not be found. Exiting."
    exit 1
  fi

  # Check if ASSET_LOCATION exists
  if [[ ! -d "${ASSET_LOCATION}" ]]; then
    log_error "ASSET_LOCATION does not exist: ${ASSET_LOCATION}. Exiting."
    exit 1
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
  find "${ASSERTION_LOCATION}" -mindepth 1 ! -name '.doorstop.yml' -delete
  find "${EVIDENCE_LOCATION}" -mindepth 1 ! -name '.doorstop.yml' -delete
  log_info "Cleanup completed"
}

process_assetdir() {
  local subdir_path=$1
  log_info "Processing subdirectory: ${subdir_path}"

  # Extract the last component of the path
  local component
  component=$(basename "${subdir_path}")
  log_info "Component: ${component}"

  # Iterate over all .tsffer files in the subdirectory
  find "${subdir_path}" -type f -name "*.tsffer" | while read -r tsffer_file; do
    log_info "Processing tsffer file: ${tsffer_file}"

    # Extract information from the .tsffer file
    local asset_name
    asset_name=$(jq -r '.["asset-info"]["name"]' "${tsffer_file}")
    local asset_description
    asset_description=$(jq -r '.["asset-info"]["description"]' "${tsffer_file}")
    local asset_type
    asset_type=$(jq -r '.["asset-info"]["type"]' "${tsffer_file}")
    local asset_url
    asset_url=$(jq -r '.["asset-info"]["download-url"]' "${tsffer_file}")
    local asset_checksum
    asset_checksum=$(jq -r '.["asset-info"]["checksum-sha256"]' "${tsffer_file}")
    local github_workflow
    github_workflow=$(jq -r '.["context-info"]["by-workflow"]' "${tsffer_file}")
    local github_ref
    github_ref=$(jq -r '.["context-info"]["ref"]' "${tsffer_file}")

    # Generate evidence text body
    local text
    text=$(evidence_text "${component}" "${asset_name}" "${asset_description}" "${asset_type}" "${asset_url}" "${asset_checksum}" "${github_workflow}" "${github_ref}")

    # create evidence file
    local file
    file=$(create_evidence "${text}")

    # link up evidence file with any TSF ids referenced by manifest
    jq -r '.["asset-info"]["tsf-ids"][]' "${tsffer_file}" | while read -r tsf_id; do
      log_info "Linking evidence to TSF ID: ${tsf_id}"
      link_evidence "${file}" "${tsf_id}"
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
  local github_workflow=$7
  local github_ref=$8

  # Construct the evidence string
  local evidence_string
  evidence_string=$(cat <<EOF
Component ${component} has an associated quality asset "${asset_name}" with the following properties:

- asset location: ${asset_url} 
- sha-256 checksum: ${asset_checksum})
- asset origin: workflow "${github_workflow}", initiated by github ref "${github_ref}"
EOF
)

  if [[ -n "${asset_type}" ]]; then
    evidence_string+=$'\n'"- asset type: ${asset_type}"
  fi
  if [[ -n "${asset_description}" ]]; then
    evidence_string+=$'\n'"- asset description: ${asset_description}"
  fi

  echo "${evidence_string}"
}

# Create evidence item
# $1: evidence_text
create_evidence() {
  local evidence_text=$1

  local output
  output=$(doorstop add up_gen_TE 2>&1)

  if [[ $? -ne 0 ]]; then
    log_error "Failed to add evidence: ${output}"
    return 1
  fi

  local filename
  filename=$(echo "${output}" | grep -oE '@/[^ ]+\.md' | sed 's|@||')

  if [[ -z "${filename}" ]]; then
    log_error "Failed to extract filename from doorstop output: ${output}"
    return 1
  fi

  echo "${evidence_text}" >> "${WORKSPACE_DIR}/${filename}"
  log_info "Created evidence item at ${filename}"

  echo ${filename}
}

link_evidence() {
  local filename=$1
  local parent_statement=$2

  # Strip path and extension to get the basename
  local basename
  basename=$(basename "${filename}" .md)
  doorstop link "${basename}" "${parent_statement}"
  log_info "Linked ${basename} to ${parent_statement}"
}

main "$@"