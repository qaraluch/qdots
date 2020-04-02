#!/bin/bash

# qdots - programs needed for this dotfiles

readonly AUR_HELPER='yay'               # installed by QALACS script (arch-bootstrap repo)

readonly packagesToInstall=(
  'fzf'                                 # [tool] command-line fuzzy finder
                                        #        need for: zsh, nvim, locate, qdots
  'the_silver_searcher'                 # [tool] alternative to grep
                                        #        need for: nvim, fzf, qdots
  'shellcheck'                          # [dev tool] shell script analysis tool
                                        #            need for shell scripts development
  'moreutils'                           # [util] shell scripting utility: ifne
                                        #        need for: fzf, nvim alias (qdots)
  'xorg-server'                         # [X11] display server for the X window
  'xorg-xinit'                          # [X11] program allows a user to manually
                                        #       start an Xorg display server.
  'xorg-xdpyinfo'                       # [X11] retrieves screen information for some scripts
  'xorg-xwininfo'                       # [X11] allows querying information about windows
  'xcompmgr'                            # [X11] utility for transparency and
                                        #       removing screen-tearing.
  'xclip'                               # [X11] command line interface to the X11 clipboard.
  'sxhkd'                               # [X11] simple X hotkey daemon.
  'libx11'                              # [X11] dependency for st compilation.
  'libxft'                              # [X11] dependency for st compilation.
  'ffmpeg'                              # [tool] software suite of libraries and programs
                                        #        for handling video audio and
                                        #        other multimedia files and streams
  'ttf-dejavu'                          # [rice] font
  'ttf-liberation'                      # [rice] font
  'screenfetch'                         # [rice] bash script that displays system
                                        #        information alongside the
                                        #        ASCII distribution logo
  # not in use:
  # 'chomium'                             # [browser] alternative
  # 'firefox'                             # [browser] alternative
)

readonly packagesToInstallAUR=(
  'brave-bin'                           # [browser] of choice.
                                        #           see: $BROWSER in ~/.zprofile
)

readonly packagesToMake=(
  'lukesmithxyz/dwm.git'                # [X11] Luke's build of dwm (windows manager)
  'LukeSmithxyz/st.git'                 # [X11] Luke's build of st (simple terminal)
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

installPackageAUR() { \
  local package
  package=${1}
  local isPackageInstalled
  isPackageInstalled=$(__isInstalledOnArch "${package}")
  if [ ${isPackageInstalled} = 'true' ] ; then
    __msgInstalled "${package}"
  else
    __msgNotInstalled "${package}"
    ${AUR_HELPER} -S --noconfirm ${package}
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

for pkg in "${packagesToInstallAUR[@]}" ; do
  installPackageAUR $pkg
done

for pkg in "${packagesToMake[@]}" ; do
  makePackage $pkg
done

