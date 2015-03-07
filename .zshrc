PATH_ARR+=($PATH)

alias ll='ls -alF'

PATH_ARR+=("$HOME/.bin/sbt/bin")

export PATH="$(IFS=:; echo "${PATH_ARR[*]}")"
