check_cmd() {
    if [ ! "$(command -v "$1")" ]; then
        app=$1
        redprint "It seems like you don't have ${app}."
        redprint "Please install ${app}."
        exit 1
    fi
}

### Colors ##
ESC=$(printf '\033')
RESET="${ESC}[0m"
BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
DEFAULT="${ESC}[39m"

### Color Functions ##

info() {
    printf "${WHITE}INFO:  %s${RESET}\n" "$1"
}

warn() {
    printf "${YELLOW}WARNING: %s${RESET}\n" "$1"
}

success() {
    printf "${GREEN}%s${RESET}\n" "$1"
}

error() {
    printf "${RED}ERROR: %s${RESET}\n" "$1" 1>&2
    exit 1
}

version() {
    echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
}

functions_list() {
  result=$(cat $src_dir/$1.sh | grep -Po $1_\\w+ | tr '\n' '|')
  echo "${result::-1}"
}

download_latest_release() {
  info "running curl --silent \"https://api.github.com/repos/$1/releases/latest\" | grep -Po \"$2\" | grep download"
  echo "https://github.com/$(curl --silent https://api.github.com/repos/$1/releases/latest | grep -Po $2 | grep download)"
}
