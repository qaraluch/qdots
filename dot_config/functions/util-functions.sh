# Utilities for qdots functions only

# qdots delimiter
readonly _QDel='[ qdots ]'

# colors
readonly _Qcr=$'\033[0;31m'            # Red
readonly _Qcg=$'\033[1;32m'            # Green
readonly _Qcy=$'\033[1;33m'            # Yellow
readonly _Qcb=$'\033[1;34m'            # Blue
readonly _Qcm=$'\033[1;35m'            # Magenta
readonly _Qcc=$'\033[1;36m'            # Cyan
readonly _Qce=$'\033[0m'               # End

# icons
readonly _Qit="[ ${_Qcg}✔${_Qce} ]"      # Tick
readonly _Qiw="[ ${_Qcy}!${_Qce} ]"      # Warn
readonly _Qic="[ ${_Qcr}✖${_Qce} ]"      # Cross
readonly _Qia="[ ${_Qcy}?${_Qce} ]"      # Ask

_echoIt() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-''} ; echo "${delimiter}${icon} $msg" >&2
}

_echoDone() {
  _echoIt "$_QDel" "DONE!" "$_Qit" ; echo >&2
}

# Switches
_isStringEqualY() {
  local string=$1
  [[ "$string" == "Y" ]]
}

_switchY() {
  local switch=$1
  if _isStringEqualY $switch; then
    return 0
  else
    return 1
  fi
}

_isStringEqualN() {
  local string=$1
  [[ "$string" == "N" ]]
}

_switchN() {
  local switch=$1
  if _isStringEqualN $switch; then
    return 0
  else
    return 1
  fi
}

# Conditionals
_isStringNotEmpty() {
  local var=$1
  [[ -n $var ]]
}

_isNotDir() {
  local dir=$1
  [[ ! -d $dir ]]
}

_isDir() {
  local dir=$1
  [[ -d $dir ]]
}
