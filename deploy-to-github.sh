#!/bin/sh

setup_git(){
   git config --global user.name "Tony Deng"
   git config --global user.email "wolf.deng@gmail.com"
   git remote add origin-pages https://github.com/tonydeng/user-stories-applied.git > /dev/null 2>&1
}

build_gitbook(){
    gitbook install
    gitbook build
}

commit_website_files(){
    git checkout -b gh-pages
    git pull origin-pages gh-pages --rebase
    cp -R _book/* .
    git clean -fx node_modules
    git clean -fx _book
    git add .
    git commit -a -m "deploy books"
}

upload_files(){
    git push --quiet --set-upstream origin-pages gh-pages
}

clean_env(){
    git remote rm origin-pages
    git checkout master
    git branch -D gh-pages
}

setup_git
build_gitbook
commit_website_files
upload_files
clean_env