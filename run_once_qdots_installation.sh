#!/bin/bash

# qdots - programs needed for this dotfiles
# basic and straightforward
# for custom builds see scripts in function:
# WMcustomBuildsAndRicing
# and
# firsttime-setup script

readonly AUR_HELPER='yay'               # installed by QALACS script (arch-bootstrap repo)

# shell essentials installation
readonly essentialPackagesToInstall=(
  'openssh'                             # [tool] secure shell
  'fzf'                                 # [tool] command-line fuzzy finder
                                        #        need for: zsh, nvim, locate, qdots
  'the_silver_searcher'                 # [tool] alternative to grep
                                        #        need for: nvim, fzf, qdots
  'shellcheck'                          # [dev tool] shell script analysis tool
                                        #            need for shell scripts development
  'moreutils'                           # [util] shell scripting utility: ifne
                                        #        need for: fzf, nvim alias (qdots)
  'wget'                                # [tool] simple tool to retrive files using
                                        #        HTTPS, HTTP, FTP, FTPS
  'pulseaudio-alsa'                     # [tool] audio system
  'pulsemixer'                          # [tool] audio controler in the terminal
  'pamixer'                             # [tool] CLI interface for audio controler
                                        #        used in status bar and scripts
  # extras
  'nodejs'                              # [dev] a bit of overkill but used
                                        #       for prettier in nvim
                                        #       also for javascript dev
  'npm'                                 # [dev] node.js package manager
                                        #       for javascript dev
)

readonly essentialPackagesToInstallAUR=(
  'tmuxinator'                          # [tool] session manager for tmux
)

# windows manager installations
readonly WMPackagesToInstall=(
  'xorg-server'                         # [X11] display server for the X window
  'xorg-xinit'                          # [X11] program allows a user to manually
                                        #       start an Xorg display server.
  'xcompmgr'                            # [X11] utility for transparency and
  'xwallpaper'                          # [X11] utility for wallpaper changing
  'xclip'                               # [X11] command line interface to the X11 clipboard.
  'unclutter'                           # [X11] hides your X mouse when idle.
  'libnotify'                           # [X11] implementation of Desktop Notifications Spec.
  'dunst'                               # [X11] lightweight notification server which uses libnotify
  'ttf-dejavu'                          # [X11][font] basic font face.
  'ttf-liberation'                      # [X11][font] basic font face.
)

readonly WMpackagesToInstallAUR=(
  'brave-bin'                           # [X11][browser] of choice.
                                        #           see: $BROWSER in ~/.zprofile
)

WMcustomBuildsAndRicing() {
  "${HOME}/bin/installs/install-st"               # [X11] run build of st (simple terminal)
  "${HOME}/bin/installs/install-dwm"              # [X11] run build of dwm (windows manager)
  "${HOME}/bin/installs/install-dwmblocks"        # [X11] run build of dwmblocks (statusbar)
  "${HOME}/bin/installs/install-dmenu"            # [X11] run build of dmenu
}

# utils
readonly _QDel='[ qdots ]'
readonly _Qcg=$'\033[1;32m'              # Green
readonly _Qcy=$'\033[1;33m'              # Yellow
readonly _Qce=$'\033[0m'                 # End
readonly _Qcr=$'\033[0;31m'              # Red
readonly _Qiw="[ ${_Qcy}!${_Qce} ]"      # Warn
readonly _Qit="[ ${_Qcg}✔${_Qce} ]"      # Tick
readonly _Qia="[ ${_Qcy}?${_Qce} ]"      # Ask
readonly _Qic="[ ${_Qcr}✖${_Qce} ]"      # Cross
_echoIt() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-''} ; echo "${delimiter}${icon} $msg" >&2
}
_errorExitConstructor() {
  local delimiter=$1 ; local msg=$2 ; local icon=${3:-"$_Qic"} ; echo "${delimiter}${icon} ${msg}" 1>&2 ; exit 1
}
_errorExit() {
  _errorExitConstructor "${_QDel}" "${1}"
}
_echoDone() {
  _echoIt "$_QDel" "DONE!" "$_Qit" ; echo >&2
}
_msgNotInstalled() {
  _echoIt "${_QDel}" "It seems that package: ${_Qcy}$1${_Qce} not installed! Intalling... " "${_Qiw}"
}
_msgInstalled() {
  _echoIt "${_QDel}" "Package: ${_Qcy}$1${_Qce} already installed! Nothing to do." "${_Qiw}"
}
_isInstalledOnArch() {
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
_yesConfirmOrSkip() {
  local msg=${1:-'Continue'}
  local msgDefaultAbort=${2:-'Abort script!'}
  read -n 1 -s -r -p "${_QDel}${_Qia} ${msg} [Y/n]?"
  echo >&2
  REPLY=${REPLY:-'Y'}
}
_isStringEqual() {
  [[ "$1" == "$2" ]]
}

installPackage() {
  local package
  package=${1}
  local isPackageInstalled
  isPackageInstalled=$(_isInstalledOnArch "${package}")
  if [ "${isPackageInstalled}" = 'true' ] ; then
    _msgInstalled "${package}"
  else
    _msgNotInstalled "${package}"
    sudo pacman -S --noconfirm "${package}"
  fi
}

installPackageAUR() { \
  local package
  package=${1}
  local isPackageInstalled
  isPackageInstalled=$(_isInstalledOnArch "${package}")
  if [ "${isPackageInstalled}" = 'true' ] ; then
    _msgInstalled "${package}"
  else
    _msgNotInstalled "${package}"
    "${AUR_HELPER}" -S --noconfirm "${package}"
  fi
}

readonly isForDesktop=$(chezmoi data | grep isitdesktop | cut -d: -f2 | sed -e 's/^\s"//' -e 's/",$//')

builds() {
  if _isStringEqual "${isForDesktop}" "yes" ; then
    _echoIt "${_QDel}" "About to install ${_Qcy}special${_Qce} packages... " "${_Qiw}"
    _yesConfirmOrSkip
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
      WMcustomBuildsAndRicing
    else
      _echoIt "${_QDel}" "... Skipped!" "${_Qic}"
    fi
    _echoDone
  fi
}

main() {
  _echoIt "${_QDel}" "About to install ${_Qcy}qdots essential${_Qce} packages... " "${_Qiw}"
  _yesConfirmOrSkip
  if [[ $REPLY =~ ^[Yy]$ ]] ; then
    for pkg in "${essentialPackagesToInstall[@]}" ; do
      installPackage "$pkg"
    done
    for pkg in "${essentialPackagesToInstallAUR[@]}" ; do
      installPackageAUR "$pkg"
    done
  else
    _echoIt "${_QDel}" "... Skipped!" "${_Qic}"
  fi
  if _isStringEqual "${isForDesktop}" "yes" ; then
    _echoIt "${_QDel}" "About to install ${_Qcy}qdots WM${_Qce} packages... " "${_Qiw}"
    _yesConfirmOrSkip
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
      for pkg in "${WMPackagesToInstall[@]}" ; do
        installPackage "$pkg"
      done
      for pkg in "${WMpackagesToInstallAUR[@]}" ; do
        installPackageAUR "$pkg"
      done
    else
      _echoIt "${_QDel}" "... Skipped!" "${_Qic}"
    fi
  fi
  _echoDone
}

main
builds
