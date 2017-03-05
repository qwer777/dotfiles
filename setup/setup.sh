#!/bin/bash
shopt -s nullglob dotglob     #To include hidden files
##Variables
GITDIR="$HOME/github.com"
#In case anyone wants to fork it, you just have to change the USER and REPO here
THISUSER=qwer777
THISREPO=dotfiles
scriptfolder="$GITDIR/$THISUSER/$THISREPO/setup"

#add the repo if it hasn't been already
if [ ! -d "$GITDIR/$THISUSER/$THISREPO" ]
then
  RenameIfExists "$GITDIR/$THISUSER/$THISREPO"
  echo "Adding the $THISREPO repo by $THISUSER into $GITDIR"
  mkdir -p "$GITDIR/$THISUSER" && cd "$GITDIR/$THISUSER" && git clone https://github.com/$THISUSER/$THISREPO.git
fi    

#add all necessary repos from RepoList file
while read line;
do
  GHUSER=$(echo $line | tr "/" " " | awk '{print $1}')
  GHREPO=$(echo $line | tr "/" " " | awk '{print $2}')
  RenameIfExists "$GITDIR/$GHUSER/$GHREPO"
  mkdir -p "$GITDIR/$GHUSER" && cd "$GITDIR/$GHUSER" && git clone https://github.com/$GHUSER/$GHREPO.git
done < "$scriptfolder/RepoList"

#copy symlinks to $HOME
for link in $scriptfolder/symlinks/*
do
  basefile="$(basename "$link")"
  RenameIfExists "$HOME/$basefile"
  echo "Copying $basefile to $HOME"
  cp -d "$link" "$HOME/$basefile"
done

##Functions
#Rename anything we're looking for that exists to $name.YYYY-MM-DD_HH:MM:SS
RenameIfExists ()
{
if [ -e "$1" ]
then 
  echo moving "$1" to "$1.$(date +%F_%T)"
  mv "$1" "$1.$(date +%F_%T)"
fi  
}
