# General purpose functions, good to have

# Timestamps
getTimeStamp() {
  date +%s
}

getTimeStampHuman() {
  date -d @"$(getTimeStamp)" +'%Y-%m-%d %H:%M:%S'
}

getTimeStampDate() {
  date -d @"$(getTimeStamp)" +'%Y-%m-%d'
}

getTimeStampHumanFile() {
  date -d @"$(getTimeStamp)" +'%Y-%m-%d_%H%M%S'
}

isInstalledOnArch() {
    local package
    package="$1"
    local check
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
    if [ -n "${check}" ] ; then
        return 0 #installed
    fi;
    return 1 # not installed
}

isGlobalExecutable() {
    local package
    package="$1"
    local check
    check="$(command -v ${package})"
    if [ -x "${check}" ] ; then
        return 0 # it is
    fi;
    return 1 # it is not
}
