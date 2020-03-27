# Better commands
# see aliases: .config/aliases

# take alias
# from oh-my-zsh
mkdir-and-cd() {
    mkdir -p $@ && cd ${@:$#}
}

# gh alias (from grep here)
ag-here() {
  local flags=(--follow --hidden --ignore .git --ignore .cache --ignore node_modules --ignore package-lock.json)
  ag "${flags[@]}" $1 ./
}

# tre alias
# is a shorthand for `tree` with hidden files and color enabled, ignoring
# the certain directories, listing directories first.
# The output gets piped into `less` with options to preserve color and line numbers,
# unless the output is small enough for one screen.
tree-better() {
  tree -aC -I '.git|.cache|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

tree-better-dirs() {
  tree -dC -a -I '.git|.cache|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
    # -a show hidden dirs
}

