#!/bin/bash

# auto sync files to Github repo

git add *
# commit message is first argument when executing script
# example: ./sync.sh added-wheel 
git commit -m '$1'
git push
