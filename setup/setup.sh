#!/bin/bash
declare -a GitRepoArray=('qwer777/dotfiles' 'zsh-users/zsh-syntax-highlighting' 'zsh-users/zsh-history-substring-search' 'robbyrussell/oh-my-zsh')
for i in "${GitRepoArray[@]}"
do
   GHUSER=$(echo $i | tr "/" " " | awk '{print $1}')
   GHREPO=$(echo $i | tr "/" " " | awk '{print $2}')
   if [ ! -d "$HOME/github.com/$GHUSER/$GHREPO" ]
   then 
      mkdir -p "$HOME/github.com/$GHUSER" && cd "$HOME/github.com/$GHUSER" && git clone https://github.com/$GHUSER/$GHREPO.git
   else
      echo "$i" already exists
   fi
done
