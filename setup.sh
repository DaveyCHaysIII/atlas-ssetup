#!/usr/bin/env bash

if [ "$#" -lt "2" ]; then
echo "not enough arguments passed\n"
echo "required: ./setup.sh {REPO} {DIRECTORY}"
exit 1
fi

repo=$1
dir=$2

#remove unneccessary files
echo "removing unneccessary files..."
cd /root
rm -r *

##Installs software
echo "installing Linter and Memory Checker..."
git clone https://github.com/hs-hq/Betty.git
apt install valgrind

##Betty Setup
echo "configuring betty..."
cd /root/Betty
/root/Betty/install.sh
cd /root

#VIM Setup
echo "setting up vim..."
echo "set nu rnu" >> /usr/share/vim/vimrc

##GIT repo clone and setup
echo "cloning repo..."
git clone https://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@github.com/DaveyCHaysIII/${repo}.git
cd /root/${repo}
if [[ ! -d "/root/${repo}/${dir}" ]]; then
	mkdir /root/${repo}/${dir}
	echo "Readme!" > /root/${repo}/${dir}/README.md
fi
	
##GIT configs
echo "setting up git config..."
git config user.email david.c.hays.iii@gmail.com
git config user.name Davey Hays
cd /root

##Alias setup for working directory
echo "PS1='\u:\w $ '" >> .bashrc
echo "creating aliases..."
touch .bash_aliases
echo "alias tt='cd /root/${repo}/${dir}'" >> .bash_aliases
echo "alias gcc='gcc -Wall -Werror -Wextra -pedantic -std=gnu89'" >> .bash_aliases
echo "alias ..='cd ..'" >> .bash_aliases
source .bash_aliases
source .bashrc
