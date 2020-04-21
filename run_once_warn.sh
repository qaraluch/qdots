#!/bin/bash
# just warning message for qdots installation script

# utils
readonly _QDel='[ qdots ]'
readonly _Qcy=$'\033[1;33m'              # Yellow
readonly _Qce=$'\033[0m'                 # End
readonly _Qiw="[ ${_Qcy}!${_Qce} ]"      # Warn
_echoIt() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-''} ; echo "${delimiter}${icon} $msg" >&2
}

main() {
  _echoIt "${_QDel}" "Please ${_Qcy}reboot${_Qce} computer!" "${_Qiw}"
  _echoIt "${_QDel}" " ... and run script: ${_Qcy}firsttime-setup${_Qce} afterwards." "${_Qiw}"
}
main
