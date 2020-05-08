# Zsh's terminal widgets and helpers (zle)
# see: .config/zsh/.zshrc-options

# zle utils
_zle-init-widget() {
  # when init widget, save what is typed in command line
  if [[ -n $1 ]]; then
    BUFFER="$1 "
    CURSOR=$#BUFFER
    zle redisplay
  fi
}

_zle-insert() {
  # from fzf-widgets
  local -a items
  IFS=$'\n' items=(`cat`)
  if [[ -n $items ]]; then
    for item in $items; do
      if [[ $1 = -q ]]; then
        # quote special characters with backslashes
        BUFFER+="$item:q:gs/\\~/~/ "
      else
        BUFFER+="$item "
      fi
    done
    BUFFER="${BUFFER% } "
    CURSOR=$#BUFFER
    zle redisplay
  else
    _zle-clear
  fi
}

_zle-clear() {
  BUFFER=""
  CURSOR=$#BUFFER
  zle redisplay
}

# For command line
zle-insert-last-typed-word() {
  # from zsh-pony repo
  # bind to shorcut: see .zshrc-options
  zle insert-last-word -- 0 -1
};
zle -N zle-insert-last-typed-word;

# For git
# see: .config/functions/git-functions.sh
# usage: in vi mode: hit <esc>, :, and type:
# - msg
# - hash
# - add
fzf-choose-git-msg() {
  echo "\"$( git-get-logs | fzf --layout=reverse --border | cut -d " " -f2-)\""
       # ^- add quotations to git msg
}
zle-fzf-git-get-commit-msg() {
  if git-is-in-repo ; then
    _zle-init-widget
    fzf-choose-git-msg | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"
  fi
}
zle -N msg zle-fzf-git-get-commit-msg

fzf-choose-git-hash() {
  echo "$( git-get-logs | \
    fzf --height 60% --layout=reverse --border | \
    cut -d " " -f1
  )"
}
zle-fzf-git-get-hash () {
  if git-is-in-repo ; then
    _zle-init-widget
    fzf-choose-git-hash | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"
  fi
}
zle -N hash zle-fzf-git-get-hash

fzf-choose-git-status-item() {
  echo "$( git-get-status-items | \
    fzf --height 40% --layout=reverse --border -m | \
    awk '{print $2}'
  )"
}
zle-fzf-git-get-status-item() {
  if git-is-in-repo ; then
    _zle-init-widget
    fzf-choose-git-status-item | \
    _zle-insert
  else
    zle -M "    ... Sorry. Not in git repo!"
  fi
}
zle -N add zle-fzf-git-get-status-item

# For locate command
fzf-choose-locate-item() {
  echo "$( locate-get-data | \
    fzf --height 40% --layout=reverse --border -m
  )"
}
zle-fzf-locate-item() {
  _zle-init-widget
  fzf-choose-locate-item | \
  _zle-insert
}
zle -N zle-fzf-locate-item
