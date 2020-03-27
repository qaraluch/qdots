# Functions for ZSH management
# Use util functions
# see: ~/.config/functions/util-functions.sh
# see aliases: .config/aliases# dependencies:

zsh-reload() {
  if [[ "$1" == "soft" ]] ; then
    # only source rc config
    source $QDOTS_ZSH_CONF_DIR/.zshrc
    _echoIt "$_QDel" "Reloaded ${_Qcy}ZSH${_Qce} shell config." "${_Qit}"
  else
    # reload enitre shell
    _echoIt "$_QDel" "About to reloaded ${_Qcy}ZSH${_Qce} shell itself..." "${_Qiw}"
    exec ${SHELL}
  fi
}
