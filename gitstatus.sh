#!/bin/bash

for f in $(find . -type d -name  .git | awk -F"/.git$" '{print $1}'); do
    echo
    echo "----------- ( dir: $f ) -----------"
    echo
    (cd "$f" && git status)
done
