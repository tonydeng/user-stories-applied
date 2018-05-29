#!/bin/bash

set -o errexit -o nounset

if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    echo "This commit was made against the $TRAVIS_BRANCH and not the master! No Deploy!"
    exit 0
fi

rev=$(git rev-parse --short HEAD)

cd _book

git init

git config user.name  "Tony Deng"
git config user.email "wolf.deng@gmail.com"

git remote add upstream "https://$GH_TOKEN@github.com/tonydeng/user-stories-applied.git"
git fetch upstream
git reset upstream/master

git add -A
git commit -m "rebuild pages at $(rev)"
git push -q upstream HEAD:master
