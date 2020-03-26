# Logs formats
export GIT_LOG_MY_FORMAT='%C(auto,yellow)%h - %C(auto,blue)%>(14,trunc)%cd - %C(reset)%s%C(auto,cyan)% gD% D %C(reset)'
export GIT_LOG_MY_FORMAT_LONG_DATE='%C(auto,yellow)%h - %C(auto,cyan) %cd %C(auto,reset) - %s%C(auto,cyan)% gD% D %C(reset)'
export GIT_LOG_MY_FORMAT_GRAPH='%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s'
git-log() {  git --no-pager log --pretty=format:"$GIT_LOG_MY_FORMAT" --abbrev-commit --date=relative "-$1" ; }
git-log-date() { git --no-pager log --pretty=format:"$GIT_LOG_MY_FORMAT_LONG_DATE" --abbrev-commit --date=format:'%Y-%m-%d %a %H:%M:%S' "-$1" ; }
git-log-tree() { git log --graph --full-history --all --color --pretty=format:"$GIT_LOG_MY_FORMAT_GRAPH" ; }

# Alias functions
git-g-alias() {
    if [[  $# -eq 0 ]]; then
      git-status-log-recent
    else
      git $*
    fi
}

git-diff() { git diff $* -- . ':(exclude)package-lock.json' ':(exclude)yarn.lock' ; }
git-idiot() { git add -A && git commit --amend --no-edit ; }
git-rebase() { git rebase -i "HEAD~$1" ; }

# Util functions
git-get-current-branch() {
  # From oh-my-zsh
  # Used also in user wsl prompt
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

git-is-in-repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

git-get-logs() {
  echo "$(git log --pretty=oneline --abbrev-commit)"
}

git-get-status-items() {
    echo "$(git status --short)"
}
