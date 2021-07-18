#!/bin/sh

if [ "$1" == "" ]; then
  echo "Requires directory"
  exit 1
fi

# run Swiftformat
swiftformat $1 --stripunusedargs closure-only --disable blankLinesAtStartOfScope --patternlet inline

# run Swiftlint
swiftlint lint --path $1 --config ../.swiftlint.yml
