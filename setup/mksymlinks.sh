#!/bin/bash
#make symlinks of files in this repo from a list

shopt -s nullglob dotglob     #To include hidden files

##Variables
#In case anyone wants to fork it, you just have to change the USER and REPO here
THIS_USER=umm7yass
THIS_REPO=dotfiles
GITHUB_DIR="/src/github.com" #Folder all repos are installed to
SETUP_FOLDER="$GITHUB_DIR/$THIS_USER/$THIS_REPO/setup" #Folder this script is in
GH_REPO_LIST_FILE="$SETUP_FOLDER/Repo_List" #File containing the list of GitHub repos in the form of USER/REPO on each line
DOTFILES_HOME_FOLDER="$HOME/.dotfiles" #Folder this repo will be linked to for easy access
SYMLINK_FILE_LIST="$SETUP_FOLDER/Symlink_List" #List of symlinks

#LIST FORMAT:Each line is formated as '$REAL_LOCATION=$SYMLINK_LOCATION
symlink_files () {
while read line;
do
  eval expanded_line="$line"
  real_file=$(echo "$expanded_line" | tr "=" " " | awk '{print $1}')
  link_file=$(echo "$expanded_line" | tr "=" " " | awk '{print $2}')
  rename_if_exists "$link_file"
  echo "Linking $real_file to $link_file"
  ln -s "$real_file" "$link_file"
done < "$1"
}

symlink_files "$SYMLINK_FILE_LIST"
