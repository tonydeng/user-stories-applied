#!/bin/sh

setup_git(){
   git config --global user.name "Travis CI"
   git config --global user.email "travis@travis-ci.org"
}


commit_website_files(){
    git checkout -b gh-pages
    git add . *.html
    git commit -a -m "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files(){
    git remote add origin-pages https://${GH_TOKEN}@github.com/tonydeng/user-stories-applied.git > /dev/null 2>&1
    git push --quiet --set-upstream origin-pages gh-pages
}

setup_git
commit_website_files
upload_files