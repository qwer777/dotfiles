#!/bin/bash
shopt -s nullglob dotglob     #To include hidden files
##Variables
#In case anyone wants to fork it, you just have to change the USER and REPO here
THIS_USER=qwer777
THIS_REPO=dotfiles
GIT_DIR="$HOME/git" #Folder all repos are installed to
THIS_SCRIPT_FOLDER="$GIT_DIR/$THIS_USER/$THIS_REPO/setup" #Folder this script is in
LINK_TO_HOME_FILE="$THIS_SCRIPT_FOLDER/SYMLINK_LIST"
GH_REPO_LIST_FILE="$THIS_SCRIPT_FOLDER/REPO_LIST" #File containing the list of GitHub repos in the form of USER/REPO on each line
DOTFILES_HOME_FOLDER="$HOME/.dotfiles" #Folder this repo will be linked to for easy access
SYMLINK_FILE_LIST="$THIS_SCRIPT_FOLDER/SYMLINK_LIST" #List of symlinks

##Functions
#add Github repos
add_gh_repo () {
gh_user=$(echo $1 | tr "/" " " | awk '{print $1}')
gh_repo=$(echo $1 | tr "/" " " | awk '{print $2}')
rename_if_exists "$GIT_DIR/$gh_user/$gh_repo"
echo "Adding the $gh_repo repo by $gh_user into $GIT_DIR"
mkdir -p "$GIT_DIR/$gh_user"
cd "$GIT_DIR/$gh_user"
git clone -q https://github.com/$gh_user/$gh_repo.git
}

#add GitHub repos from file
#LIST FORMAT:Each line is formated as '$USER/$REPO'
add_gh_repos_from_file () {
while read line;
do
  add_gh_repo $line
done < "$1"
}

#Main function
main() {
add_gh_repo "$THIS_USER/$THIS_REPO"
add_gh_repos_from_file "$GH_REPO_LIST_FILE"
symlink_files "$SYMLINK_FILE_LIST"
}

#Rename anything we're looking for that exists to $name.YYYY-MM-DD_HH:MM:SS
rename_if_exists () {
if [ -e "$1" ]
then
  echo moving "$1" to "$1.$(date +%F_%T)"
  mv "$1" "$1.$(date +%F_%T)"
fi
}

#make symlinks of files in this repo from a list
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

main "$@"
