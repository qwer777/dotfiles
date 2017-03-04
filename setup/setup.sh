#!/bin/bash
shopt -s nullglob dotglob     #To include hidden files
scriptfolder="$HOME/github.com/qwer777/dotfiles/setup"

#add the repo if it hasn't been already
if [ ! -e "$HOME/github.com/qwer777/dotfiles" ]
then
    echo "Adding the dotfiles repo by qwer777"
    mkdir -p "$HOME/github.com/qwer777" && cd "$HOME/github.com/qwer777" && git clone https://github.com/qwer777/dotfiles.git
fi    

#add all necessary repos
while read line;
  do
    GHUSER=$(echo $line | tr "/" " " | awk '{print $1}')
    GHREPO=$(echo $line | tr "/" " " | awk '{print $2}')
    if [ -e "$HOME/github.com/$GHUSER/$GHREPO" ]
    then 
      echo moving "$line" to "$line.$(date +%F_%T)"
      mv "$HOME/github.com/$GHUSER/$GHREPO" "$HOME/github.com/$GHUSER/$GHREPO.$(date +%F_%T)"
    fi
    mkdir -p "$HOME/github.com/$GHUSER" && cd "$HOME/github.com/$GHUSER" && git clone https://github.com/$GHUSER/$GHREPO.git
done < "$scriptfolder/repolist"

#move symlinks to $HOME
for link in $scriptfolder/symlinks/*
  do
    basefile="$(basename "$link")"
    if [ -e "$HOME/$basefile" ]
      then
        echo Moving "$basefile" to "$basefile.$(date +%F_%T)"
        mv "$HOME/$basefile" "$HOME/$basefile.$(date +%F_%T)"
      fi
    echo "Copying $basefile to $HOME"
    cp -d "$link" "$HOME/$basefile"
  done
