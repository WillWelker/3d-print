#!/bin/bash

#auto sync files to Github repo

git add *
#commit message is first argument when executing script
git commit -m '$1'
git push
