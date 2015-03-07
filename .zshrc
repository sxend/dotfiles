PATH_ARR+=($PATH)

alias ll='ls -al'

PATH_ARR+=("$HOME/.bin/sbt/bin")

export PATH="$(IFS=:; echo "${PATH_ARR[*]}")"
