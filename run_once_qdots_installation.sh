#!/bin/bash

# qdots - programs needed for this dotfiles

readonly packagesToInstall=(
  'fzf'
  'the_silver_searcher'
  'shellcheck'
  'moreutils'
)

readonly packagesToMake=(
  'lukesmithxyz/dwm.git'
)

# utils
readonly _QDel='[ qdots ]'
readonly _Qcg=$'\033[1;32m'              # Green
readonly _Qcy=$'\033[1;33m'              # Yellow
readonly _Qce=$'\033[0m'                 # End
readonly _Qiw="[ ${_Qcy}!${_Qce} ]"      # Warn
readonly _Qit="[ ${_Qcg}✔${_Qce} ]"      # Tick
__echoIt() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-''} ; echo "${delimiter}${icon} $msg" >&2
}
__msgNotInstalled() {
  __echoIt "${_QDel}" "It seems that package: ${_Qcy}$1${_Qce} not installed! Intalling... " "${_Qiw}"
}
__msgMakePackage() {
  __echoIt "${_QDel}" "About to clone, make and make install package: ${_Qcy}$1${_Qce} ... " "${_Qiw}"
}
__msgInstalled() {
  __echoIt "${_QDel}" "Package: ${_Qcy}$1${_Qce} already installed! Nothing to do." "${_Qiw}"
}
__isInstalledOnArch() {
    # duplicate with fn in general-functions.sh file
    # have to be a standalone script - can not depend on other helpers
    local package
    package="$1"
    local check
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
    if [ -n "${check}" ] ; then
        return 0 #installed
    fi;
    return 1 # not installed
}

installPackage() {
  local package
  package=${1}
  local isPackageInstalled
  isPackageInstalled=$(__isInstalledOnArch "${package}")
  if ${isPackageInstalled} ; then
    __msgInstalled "${package}"
  else
    __msgNotInstalled "${package}"
    sudo pacman -S --noconfirm "${package}"
  fi
}

makePackage() {
  local package
  package=${1}
  local dir
  __msgMakePackage "${package}"
  dir=$(mktemp -d)
	git clone --depth 1 "https://github.com/${package}" "$dir"
	cd "$dir"
	sudo make
	sudo make install
}

for pkg in "${packagesToInstall[@]}" ; do
  installPackage $pkg
done

for pkg in "${packagesToMake[@]}" ; do
  makePackage $pkg
done

