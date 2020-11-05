#!/bin/bash
# Setup Tmux

# utils
readonly _QDel='[ qdots ]'
readonly _Qcy=$'\033[1;33m'              # Yellow
readonly _Qce=$'\033[0m'                 # End
readonly _Qiw="[ ${_Qcy}!${_Qce} ]"      # Warn
_echoIt() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-''} ; echo "${delimiter}${icon} $msg" >&2
}

main() {
    _echoIt "${_QDel}" "About to setup: ${_Qcy}TPM${_Qce} for Tmux!" "${_Qiw}"
    install-tmux-tpm
}
main
