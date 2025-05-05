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


# Define log levels
LOG_LEVEL_ERROR=0
LOG_LEVEL_WARN=1
LOG_LEVEL_INFO=2
LOG_LEVEL_DEBUG=3

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

get_timestamp() {
  # shellcheck disable=SC2154
  if [[ "${LOG_TIMESTAMP}" == "true" ]]; then  
    echo "$(date '+%Y-%m-%d %H:%M:%S') "
  else
    echo ""
  fi
}

# Logging functions
log_error() {
  # shellcheck disable=SC2154
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_ERROR} ]]; then
    echo -e "${RED}[ERROR]${NC} $(get_timestamp)$*" >&2
  fi
}

log_warn() {
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_WARN} ]]; then
    echo -e "${YELLOW}[WARN]${NC}  $(get_timestamp)$*" >&2
  fi
}

log_info() {
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_INFO} ]]; then
    echo "[INFO]  $(get_timestamp)$*"
  fi
}

log_debug() {
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_DEBUG} ]]; then
    echo -e "${BLUE}[DEBUG]${NC} $(get_timestamp)$*"
  fi
}
