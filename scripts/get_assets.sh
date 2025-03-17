#!/bin/bash

# Copyright (C) 2025 ETAS 
# 
# This program and the accompanying materials are made available under the
# terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0.
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
# 
# SPDX-License-Identifier: Apache-2.0

# shellcheck source=logging.sh
source lib/logging.sh
source lib/asset_types.sh

CURRENT_LOG_LEVEL=${LOG_LEVEL:-${LOG_LEVEL_DEBUG}}
LOG_TIMESTAMP=${LOG_TIMESTAMP:-"off"}

WORKSPACE_DIR="/up-trustable-release"
ASSET_LOCATION="${WORKSPACE_DIR}/release_artifacts"

print_help() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -v                Increase verbosity level"
  echo "  -t                Enable logging timestamps"
  echo "  -w <directory>    Set the workspace directory"
  echo "  --cleanup         Clean up asset location"
  echo "  --help            Display this help message"
}

main() {
 # Parse command line arguments
  while getopts "vtw:-:" opt; do
    case ${opt} in
      v)
        ((CURRENT_LOG_LEVEL++))
        ;;
      t)
        LOG_TIMESTAMP="on"
        ;;
      w)
        WORKSPACE_DIR="${OPTARG}"
        ASSET_LOCATION="${WORKSPACE_DIR}/release_artifacts"
        ;;
      -)
        case "${OPTARG}" in
          help)
            print_help
            exit 0
            ;;
          cleanup)
            cleanup
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

  # Loop through each directory in ASSET_LOCATION and call retrieve_assets
  for dir in "${ASSET_LOCATION}"/*/; do
    if [[ -d "${dir}" ]]; then
      log_info "Processing assets in directory: ${dir}"
      retrieve_assets "${dir}"
    fi
  done
}

cleanup() {
  log_info "Cleaning up asset location"
  rm -rf "${ASSET_LOCATION:?}"/*
  log_info "Cleanup completed"
}

# Function to retrieve the manifest file for a component
retrieve_manifests() {
  local component_data=$1 
  local component=$(echo "${component_data}" | jq -r '.component')
  local url=$(echo "${component_data}" | jq -r '.url')
  local base_url=${url//tag/download}
  local manifest_url="${base_url}/manifest.toml"
  
  # Create release-artifacts subdirectory for every component and retrieve the manifest
  log_info "Retrieving manifest from: ${manifest_url}"
  mkdir -p "${ASSET_LOCATION}/${component}"
  if ! wget -q -O "${ASSET_LOCATION}/${component}/manifest.toml" "${manifest_url}"; then
    log_error "Failed to retrieve manifest from: ${manifest_url}"
    rm -rf "${ASSET_LOCATION:?}/${component}"
  fi
}

# Function to retrieve all release assets for a component as referenced in its manifest.toml
retrieve_assets() {
  local path=$1
  local manifest_file="${path}/manifest.toml"
  
  if [[ ! -f "${manifest_file}" ]]; then
    log_error "Manifest file not found: ${manifest_file}"
    exit 1
  fi
    
  # Process each section, downloading all referenced assets
  for section in "${ASSET_TYPES[@]}"; do
    log_info "Processing section: ${section}"
    local url_list=$(toml get ${manifest_file} metadata.${section})
    local -a asset_urls=()

    extract_urls_to_array "${url_list}" asset_urls

    # Debug: print array count and contents
    log_debug "Found ${#asset_urls[@]} assets in section: ${section}"
    for ((i=0; i<${#asset_urls[@]}; i++)); do
      log_debug "Downloading asset[${i}]: ${asset_urls[${i}]}"
      mkdir -p "${path}/${section}"
      wget -qP "${path}/${section}" "${asset_urls[${i}]}"
    done
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
  
  local repo=$(echo "${url}" | sed -E 's|https://github.com/(.+)/releases/tag/(.+)|\1|')
  local project=$(echo "${repo}" | cut -d'/' -f1)
  local component=$(echo "${repo}" | cut -d'/' -f2)
  local tag=$(echo "${url}" | sed -E 's|https://github.com/(.+)/releases/tag/(.+)|\2|')
  
  # Create JSON string using jq
  local json_string=$(jq -n \
    --arg url "${url}" \
    --arg repo "${repo}" \
    --arg project "${project}" \
    --arg component "${component}" \
    --arg tag "${tag}" \
    '{url: $url, repository: $repo, project: $project, component: $component, tag: $tag}')
  
  echo "${json_string}"
}

main "$@"