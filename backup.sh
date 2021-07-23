#!/bin/bash

_git_branch=server/${HOSTNAME}

git checkout -b ${_git_branch}
source scripts/backup-pkgs.sh -b

git add *
git commit -m "dotfile backup from ${HOSTNAME} on $(date)"
git push
