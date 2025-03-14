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

module logging

CURRENT_LOG_LEVEL=${LOG_LEVEL:-${LOG_LEVEL_DEBUG}}
WORKSPACE_DIR="/up-trustable-release"
ASSET_LOCATION="${WORKSPACE_DIR}/release-artifacts"


main() {
  mkdir -p ${ASSET_LOCATION}

  # Parse command line arguments
  while getopts "v" opt; do
    case ${opt} in
      v)
        ((CURRENT_LOG_LEVEL++))
        ;;
      *)
        ;;
    esac
  done

  # Array to hold all extracted URLs
  local -a urls=()
  
  # Extract URLs into the urls array
  extract_urls_to_array "${UP_TSF_COMPONENT_RELASES:?}" urls
  
  # Debug: print array count and contents
  log_debug "Found ${#urls[@]} URLs:"
  for ((i=0; i<${#urls[@]}; i++)); do
    log_debug "URL[${i}]: ${urls[${i}]}"
    
    # Process URL and get JSON
    json_result=$(process_url "${urls[${i}]}")
    log_debug "JSON[${i}]: ${json_result}"
    log_debug "---"
    
    retrieve_manifests "${json_result}"
  done

  # Loop through each directory in ASSET_LOCATION and call retrieve_assets
  for dir in "${ASSET_LOCATION}"/*/; do
    if [[ -d "${dir}" ]]; then
      log_info "Processing assets in directory: ${dir}"
      retrieve_assets "${dir}"
    fi
  done
}

retrieve_manifests() {
  local json_result=$1
  
  # Extract URL from JSON result using jq
  local component=$(echo "${json_result}" | jq -r '.component')
  local url=$(echo "${json_result}" | jq -r '.url')
  local base_url=${url//tag/download}
  local manifest_url="${base_url}/manifest.toml"
  
  # Use wget to retrieve the manifest
  log_info "Retrieving manifest from: ${manifest_url}"
  mkdir -p "${ASSET_LOCATION}/${component}"
  if ! wget -qP "${ASSET_LOCATION}/${component}" "${manifest_url}"; then
    log_error "Failed to retrieve manifest from: ${manifest_url}"
    rm -rf "${ASSET_LOCATION:?}/${component}"
  fi
}

retrieve_assets() {
  local path=$1
  local manifest_file="${path}/manifest.toml"
  
  if [[ ! -f "${manifest_file}" ]]; then
    log_error "Manifest file not found: ${manifest_file}"
    exit 1
  fi
  
  # Sections to process
  local sections=("requirements" "readme" "licensing" "testing")
  
  # Process each section
  for section in "${sections[@]}"; do
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

# Function to extract URLs from UP_TSF_COMPONENT_RELASES into an array
extract_urls_to_array() {
  log_debug "Extracting URLs from: $1"

  local -n url_array=$2  # Reference to the array passed as parameter
  
  # Remove the brackets and split by commas
  # shellcheck disable=SC2154
  local raw_values=$(echo "$1" | sed 's/^\[//;s/\]$//')
  
  # Use IFS to split the values
  local IFS=','
  local raw_urls=(${raw_values})
  unset IFS
    
  # Process each URL
  for ((i=0; i<${#raw_urls[@]}; i++)); do
    # Remove the quotes if present
    local clean_url=${raw_urls[${i}]//[\"\']/}
    clean_url=$(echo "${clean_url}" | xargs)  # Trim whitespace        
    url_array[i]="${clean_url}"
  done
}

# Function to process a single URL and return a JSON string
process_url() {
  local url=$1
  
  # Extract components
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
  
  # Return the JSON string
  echo "${json_string}"
}