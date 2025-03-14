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

# Logging functions
log_error() {
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_ERROR} ]]; then
    echo -e "${RED}[ERROR]${NC} $*" >&2
  fi
}

log_warn() {
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_WARN} ]]; then
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
  fi
}

log_info() {
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_INFO} ]]; then
    echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') $*"
  fi
}

log_debug() {
  if [[ ${CURRENT_LOG_LEVEL} -ge ${LOG_LEVEL_DEBUG} ]]; then
    echo -e "${BLUE}[DEBUG]${NC} $*"
  fi
}
