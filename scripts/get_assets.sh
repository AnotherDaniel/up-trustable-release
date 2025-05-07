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

# shellcheck source=logging.sh
source lib/logging.sh

WORKSPACE_DIR="/up-trustable-release"

ASSET_DOWNLOAD=${ASSET_DOWNLOAD:-"true"}
ASSET_LOCATION="${WORKSPACE_DIR}/release_artifacts"
CURRENT_LOG_LEVEL=${LOG_LEVEL:-${LOG_LEVEL_DEBUG}}
LOG_TIMESTAMP=${LOG_TIMESTAMP:-"false"}

print_help() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -n, --no-download  Do not download actual release assets (only download tsffer manifests)"  
  echo "  -t                 Enable logging timestamps"
  echo "  -v                 Increase verbosity level"
  echo "  -w <directory>     Set the workspace directory"
  echo "  --cleanup          Clean up component manifest data"
  echo "  --help             Display this help message"
}

main() {
 # Parse command line arguments
  while getopts "ntvw:-:" opt; do
    case ${opt} in
      n)
        ASSET_DOWNLOAD="false"
        ;;
      t)
        LOG_TIMESTAMP="true"
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
          no-download)
            ASSET_DOWNLOAD="false"
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

  # Check if gh binary is available
  if ! command -v gh &> /dev/null; then
    log_error "gh binary could not be found. Exiting."
    exit 1
  fi

  mkdir -p ${ASSET_LOCATION}

  # Array to hold all release component URLs from UP_TSF_COMPONENT_RELASES
  local -a urls=()
  extract_urls_to_array "${UP_TSF_COMPONENT_RELASES:?}" urls
  
  # Debug: print array count and contents
  log_debug "Found ${#urls[@]} URLs:"

  for ((i=0; i<${#urls[@]}; i++)); do
    log_debug "URL[${i}]: ${urls[${i}]}"
    
    # Process URL and get JSON
    component_data=$(process_url "${urls[${i}]}")
    
    retrieve_manifests "${component_data}"
  done

  if [[ "${ASSET_DOWNLOAD}" == "true" ]]; then  
    # Loop through each directory in ASSET_LOCATION and call retrieve_assets
    for dir in "${ASSET_LOCATION}"/*/; do
      if [[ -d "${dir}" ]]; then
        log_info "Processing assets in directory: ${dir}"
        retrieve_assets "${dir}"
      fi
    done
  fi
}

# Function to retrieve the manifest file for a component
retrieve_manifests() {
  local component_data=$1 
  local repository=$(echo "${component_data}" | jq -r '.repository')  
  local component=$(echo "${component_data}" | jq -r '.component')
  local url=$(echo "${component_data}" | jq -r '.url')
  
  # Create release-artifacts subdirectory for every component and retrieve the manifest
  log_info "Retrieving manifest from: ${url}"

  mkdir -p "${ASSET_LOCATION}/${component}"
  if ! gh release download --repo ${repository} --pattern '*.tsffer' --dir "${ASSET_LOCATION}/${component}"; then
    log_error "Failed to download tsffer manifests from: ${url}"
    rm -rf "${ASSET_LOCATION:?}/${component}"
  fi
}

# Function to retrieve all release assets for a component as referenced in downloaded .tsffer manifests
retrieve_assets() {
  local path=$1

  find "${path}" -type f -name "*.tsffer" | while read -r tsffer_file; do
    log_info "Processing tsffer file: ${tsffer_file}"

    # Extract information from the .tsffer file
    local download_url
    download_url=$(jq -r '.["asset-info"]["download-url"]' "${tsffer_file}")
    local name
    name=$(jq -r '.["asset-info"]["name"]' "${tsffer_file}")

    # Log the extracted information
    log_info "Download URL: ${download_url} for asset name: ${name}"

    # Download the asset using the extracted URL
    if [[ -n "${download_url}" ]]; then
      curl --no-progress-meter -LO --output-dir "${path}" "${download_url}" || log_error "Failed to download ${download_url}"
    else
      log_error "Invalid tsffer file: ${tsffer_file}"
    fi
  done
}

# Function to extract URLs into an array
# URLs are passed in as first argument, array is passed in as second argument
# URL argument format is ['https://url.a', 'https://url.b', ...]
extract_urls_to_array() {
  log_debug "Extracting URLs from: $1"

  local -n url_array=$2 
  
  # Remove the brackets and split by commas
  local raw_values=$(echo "$1" | sed 's/^\[//;s/\]$//')
  
  # Use IFS to split the values
  local IFS=','
  local raw_urls=(${raw_values})
  unset IFS
    
  for ((i=0; i<${#raw_urls[@]}; i++)); do
    local clean_url=${raw_urls[${i}]//[\"\']/}
    clean_url=$(echo "${clean_url}" | xargs)  # Trim whitespace        
    # shellcheck disable=SC2034
    url_array[i]="${clean_url}"
  done
}

# Function to process a single URL and return its components as a JSON string
process_url() {
  local url=$1
  local hostname=$(echo "${url}" | awk -F/ '{print $3}')
  local repository=$(echo "${url}" | sed -E 's|https://github.com/(.+)/releases/tag/(.+)|\1|')
  local project=$(echo "${repository}" | cut -d'/' -f1)
  local component=$(echo "${repository}" | cut -d'/' -f2)
  local tag=$(echo "${url}" | sed -E 's|https://github.com/(.+)/releases/tag/(.+)|\2|')
  
  # Create JSON string using jq
  local json_string=$(jq -n \
    --arg url "${url}" \
    --arg hostname "${hostname}" \
    --arg repository "${repository}" \
    --arg project "${project}" \
    --arg component "${component}" \
    --arg tag "${tag}" \
    '{url: $url, hostname: $hostname, repository: $repository, project: $project, component: $component, tag: $tag}')
  
  echo "${json_string}"
}

cleanup() {
  log_info "Cleaning up component manifest data"
  find "${ASSET_LOCATION}" -mindepth 1 -delete
  log_info "Cleanup completed"
}

main "$@"