#!/bin/bash
# Setup ZSH shell
# sourcing in .config/zsh/.zshrc

# utils
readonly _QDel='[ qdots ]'
readonly _Qcg=$'\033[1;32m'              # Green
readonly _Qcy=$'\033[1;33m'              # Yellow
readonly _Qce=$'\033[0m'                 # End
readonly _Qiw="[ ${_Qcy}!${_Qce} ]"      # Warn
readonly _Qit="[ ${_Qcg}✔${_Qce} ]"      # Tick
_echoIt() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-''} ; echo "${delimiter}${icon} $msg" >&2
}
_echoDone() {
  _echoIt "$_QDel" "DONE!" "$_Qit" ; echo >&2
}

# 0. vars
readonly zshcachedir="$HOME/.cache/zsh"
readonly zshdir="$HOME/.local/share/zsh"

# 1. Setup dir for zsh completion and history
# see: .config/zsh/.zshrc
mkdir -p "${zshcachedir}"
mkdir -p "${zshdir}"

# 2. Zsh plugin installation: FZF-MARKS
# Home URL: [urbainvaes/fzf-marks: Plugin to manage bookmarks in bash and zsh](https://github.com/urbainvaes/fzf-marks)
readonly fzfmarks_plugName='fzf-marks'
readonly fzfmarks_plugGitURL='https://github.com/urbainvaes/fzf-marks.git'
readonly fzfmarks_plugCacheDirPath="${zshcachedir}/plugs/${fzfmarks_plugName}"
readonly fzfmarks_plugCommandDownload=( git clone --depth 1 "${fzfmarks_plugGitURL}" "${fzfmarks_plugCacheDirPath}" )
plug-install-fzf-marks() {
    if [[ ! -d $fzfmarks_plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${fzfmarks_plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${fzfmarks_plugCommandDownload[@]}")
        _echoDone
    fi
}
plug-install-fzf-marks

# 3. Zsh plugin installation: ZSH-ABBREV-ALIAS
# Home URL: [momo-lab/zsh-abbrev-alias: This zsh plugin provides functionality similar to Vim's abbreviation expansion.](https://github.com/momo-lab/zsh-abbrev-alias)
readonly zshabbrevalia_plugName='zsh-abbrev-alias'
readonly zshabbrevalia_plugGitURL='https://github.com/momo-lab/zsh-abbrev-alias.git'
readonly zshabbrevalia_plugCacheDirPath="${zshcachedir}/plugs/${zshabbrevalia_plugName}"
readonly zshabbrevalia_plugCommandDownload=( git clone --depth 1 "${zshabbrevalia_plugGitURL}" "${zshabbrevalia_plugCacheDirPath}" )
plug-install-zsh-abbrev-alias() {
    if [[ ! -d $zshabbrevalia_plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${zshabbrevalia_plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${zshabbrevalia_plugCommandDownload[@]}")
        _echoDone
    fi
}
plug-install-zsh-abbrev-alias

# 4. Zsh plugin installation: ZSH-AUTOSUGGESTIONS
# Home URL: [zsh-users/zsh-autosuggestions: Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)
readonly zshautosuggestions_plugName='zsh-autosuggestions'
readonly zshautosuggestions_plugGitURL='https://github.com/zsh-users/zsh-autosuggestions.git'
readonly zshautosuggestions_plugCacheDirPath="${zshcachedir}/plugs/${zshautosuggestions_plugName}"
readonly zshautosuggestions_plugCommandDownload=( git clone --depth 1 "${zshautosuggestions_plugGitURL}" "${zshautosuggestions_plugCacheDirPath}" )
plug-install-zsh-autosuggestions() {
    if [[ ! -d $zshautosuggestions_plugCacheDirPath ]]; then
        _echoIt "$_QDel" "It seems you have no installed a '${_Qcy}${zshautosuggestions_plugName}${_Qce}' plugin." "$_Qiw"
        _echoIt "$_QDel" "About to install it..."
        local execPlugCommand=$("${zshautosuggestions_plugCommandDownload[@]}")
        _echoDone
    fi
}
plug-install-zsh-autosuggestions

