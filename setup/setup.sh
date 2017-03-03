#!/bin/bash
scriptfolder="$(dirname "${BASH_SOURCE}")"
while read line;
  do
    GHUSER=$(echo $line | tr "/" " " | awk '{print $1}')
    GHREPO=$(echo $line | tr "/" " " | awk '{print $2}')
    if [ -e "$HOME/github.com/$GHUSER/$GHREPO" ]
    then 
      mv "$HOME/github.com/$GHUSER/$GHREPO" "$HOME/github.com/$GHUSER/$GHREPO.$(date +%F_%T)"
    fi
    mkdir -p "$HOME/github.com/$GHUSER" && cd "$HOME/github.com/$GHUSER" && git clone https://github.com/$GHUSER/$GHREPO.git
done < "$scriptfolder/repolist"

for link in $scriptfolder/symlink/*
  do
    basefile="$(basename "$link")"
    if [ -e "$HOME/$basefile" ]
      mv "$HOME/$basefile" "$HOME/$basefile.$(date +%F_%T)"
    fi
    cp -d "$link" "$HOME/$basefile"
  done
