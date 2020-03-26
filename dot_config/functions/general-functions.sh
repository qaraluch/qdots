# General purpose functions, good to have

# Timestamps
getTimeStamp() {
  echo $(date +%s)
}

getTimeStampHuman() {
  echo $(date -d @"$(_getTimeStamp)" +'%Y-%m-%d %H:%M:%S')
}

getTimeStampDate() {
  echo $(date -d @"$(_getTimeStamp)" +'%Y-%m-%d')
}

getTimeStampHumanFile() {
  echo $(date -d @"$(_getTimeStamp)" +'%Y-%m-%d_%H%M%S')
}
