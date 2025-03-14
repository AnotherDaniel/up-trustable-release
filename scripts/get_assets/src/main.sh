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
  extract_urls_to_array urls
  
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
}

retrieve_manifests() {
local json_result=$1
  
  # Extract URL from JSON result using jq
  local url=$(echo "${json_result}" | jq -r '.url')
  local component=$(echo "${json_result}" | jq -r '.component')
  
  # Construct the manifest URL
  local manifest_url="${url}/manifest.toml"
  
  # Use curl to retrieve the manifest
  log_info "Retrieving manifest from: ${manifest_url}"
  mkdir -p "${ASSET_LOCATION}/${component}"
  # curl -O "${manifest_url}" > "${ASSET_LOCATION}/${component}/manifest.toml"
}
 
# Function to extract URLs from UP_TSF_COMPONENT_RELASES into an array
extract_urls_to_array() {
  local -n url_array=$1  # Reference to the array passed as parameter
  
  # Remove the brackets and split by commas
  # shellcheck disable=SC2154
  local raw_values=$(echo "${UP_TSF_COMPONENT_RELASES}" | sed 's/^\[//;s/\]$//')
  
  # Use more reliable IFS to split the values
  local IFS=','
  local raw_urls=(${raw_values})
  
  # Reset IFS
  unset IFS
  
  # Debug
  log_debug "Found ${#raw_urls[@]} raw URLs"
  
  # Process each URL
  for ((i=0; i<${#raw_urls[@]}; i++)); do
    # Remove the quotes if present
    local clean_url=${raw_urls[${i}]//[\"\']/}
    clean_url=$(echo "${clean_url}" | xargs)  # Trim whitespace
    
    log_debug "Clean URL: '${clean_url}'"
    
    # Add to the array
    url_array[${i}]="${clean_url}"
  done
  
  # Debug - verify array was populated
  log_debug "URL array now has ${#url_array[@]} elements"
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