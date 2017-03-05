#!/bin/bash
shopt -s nullglob dotglob     #To include hidden files
##Variables
#In case anyone wants to fork it, you just have to change the USER and REPO here
THIS_USER=qwer777
THIS_REPO=dotfiles
GIT_DIR="$HOME/git" #Folder all repos are installed to
THIS_SCRIPT_FOLDER="$GIT_DIR/$THIS_USER/$THIS_REPO/setup" #Folder this script is in
COPY_TO_HOME_FOLDER="$THIS_SCRIPT_FOLDER/COPY_TO_HOME" #Folder that contains the files to copy to $HOME
GH_REPO_LIST_FILE="$THIS_SCRIPT_FOLDER/RepoList" #File containing the list of GitHub repos in the form of USER/REPO on each line

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

#add all GitHub repos from $GH_REPO_LIST_FILE file
add_gh_repos_from_file () {
while read line;
do
  add_gh_repo $line
done < "$1"
}

#copy items to $HOME
copy_to_home () {
for item in $COPY_TO_HOME_FOLDER/*
do
  basefile="$(basename "$item")"
  rename_if_exists "$HOME/$basefile"
  echo "Copying $basefile to $HOME"
  cp -d "$item" "$HOME/$basefile"
done
}

#Main function
main() {
add_gh_repo "$THIS_USER/$THIS_REPO"
add_gh_repos_from_file "$GH_REPO_LIST_FILE"
copy_to_home
}
 
#Rename anything we're looking for that exists to $name.YYYY-MM-DD_HH:MM:SS
rename_if_exists () {
if [ -e "$1" ]
then 
  echo moving "$1" to "$1.$(date +%F_%T)"
  mv "$1" "$1.$(date +%F_%T)"
fi  
}

main "$@"
