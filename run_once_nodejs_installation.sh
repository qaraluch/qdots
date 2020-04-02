#!/bin/bash

# qdots - node.js and npm installation
# need for dev
# need for nvim plugin: prettier/vim-prettier
# see: .config/nvim/init.nvim

readonly packagesToInstall=( 'nodejs' 'npm')

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
    echo 'true'
  else
    echo 'false'
  fi;
}

installPackage() {
  local package
  package=${1}
  local isPackageInstalled
  isPackageInstalled=$(__isInstalledOnArch "${package}")
  if [ ${isPackageInstalled} = 'true' ] ; then
    __msgInstalled "${package}"
  else
    __msgNotInstalled "${package}"
    sudo pacman -S --noconfirm "${package}"
  fi
}

for pkg in "${packagesToInstall[@]}" ; do
  installPackage $pkg
done

