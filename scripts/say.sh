#!/usr/bin/env sh

# https://github.com/ss-o/dotfiles/blob/2e9b71eb9c29e49c0cb408d5efc00b011ec10e7d/install.sh

[ -z "${_user_home}" ] && _user_home="${HOME}"
_time_stamp=$(date +%D)
_backup_dir="${_user_home}/.backup/${_time_stamp}"
_logfile="${_user_home}/.backup/${_time_stamp}/install.log"

# Check environment
_is_quiet="${_is_quiet:-false}"
_is_tty="${_is_tty:-false}"
_is_piped="${_is_piped:-false}"

say() {
  while [ -n "$1" ]; do
    one_line=0
    case "$1" in
    -normal) col="\033[00m" ;;
    -black) col="\033[30;01m" ;;
    -red) col="\033[31;01m" ;;
    -green) col="\033[32;01m" ;;
    -yellow) col="\033[33;01m" ;;
    -blue) col="\033[34;01m" ;;
    -magenta) col="\033[35;01m" ;;
    -cyan) col="\033[36;01m" ;;
    -white) col="\033[37;01m" ;;
    -n)
      one_line=1
      shift
      continue
      ;;
    *)
      printf '%s\033[00m' "${1}"
      shift
      continue
      ;;
    esac
    shift
    printf "${col}%s\033[00m" "$1"
    shift
  done
  [ "${one_line}" = 1 ] || printf "\n"
}


err() {
  say -red "$1" >&2
  exit 1
}


say_ok() {
  # Don't print anything if we're in quiet mode
  [ "${_is_quiet}" = "true" ] && return 0
  printf "\033[34;1m▓▒░\033[32;01m ✔ \033[00m» "
  say -green "$1"
  printf "\033[00m"
  return 0
}


say_info() {
  # Don't print anything if we're in quiet mode
  [ "${_is_quiet}" = "true" ] && return 0
  printf "\033[34;1m▓▒░\033[35;01m ❢ \033[00m» "
  say -magenta "$1"
  printf "\033[00m"
  return 0
}


say_warn() {
  # Don't print anything if we're in quiet mode
  [ "${_is_quiet}" = "true" ] && return 0
  printf "\033[34;1m▓▒░\033[33;01m ❢ \033[00m» "
  say -yellow "$1"
  printf "\033[00m"
}


say_err() {
  printf "\033[34;01m▓▒░\033[31;01m ✘ \033[00m» "
  say -red "$1" >&2
  printf "\033[00m"
  exit 1
}


say_log() {
  [ -d "${_backup_dir}" ] || command mkdir -p "${_backup_dir}"
  say_info "$1 -- $(date || true)" | command tee -a "${_logfile}" >/dev/null
}

main() {
    say_ok "This is ok"
    say_info "This is info"
    say_warn "This is warn"
    say_log "This is log"
    say_err "This is err"
    err "err"
}

main "$@"
