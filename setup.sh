#!/bin/bash

echo "Start Start Start !!!\n"
echo "Install app"
if which apt-get >/dev/null; then
	sudo apt-get install -y vim vim-gtk ctags cscope xclip git astyle tmux cmake g++
    sudo apt-get install -y python python3  python-dev python3-dev
    # ale check tool install
    sudo apt-get install -y clang cppcheck pylint flake8 shellcheck golint
    pip install flake8
    pip install pygments
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags cscope xclip  astyle tmux cmake g++
	sudo yum install -y python python3 python-devel python3-devel
	sudo yum install -y clang cppcheck pylint flake8 shellcheck golint
    	sudo pip install flake8
	#sudo pip install   --proxy=xxx
    	sudo pip install pygments
elif which brew >/dev/null; then
    brew install vim
	brew install ctags cscope  tmux git astyle cmake
	brew install python@2 python@3
	brew install cppcheck  flake8 shellcheck
	pip install pylink-square
	pip install flake8
	pip install pygments

	brew install go
	go get -u github.com/golang/lint/golint

	## mac can auto install global and ctags
	brew install global
	brew unlink ctags
	brew install --HEAD universal-ctags/universal-ctags/universal-ctags
fi

rm ~/.vim_old_lcd/ -rf
rm ~/.vimrc_old_lcd -f

mv -f ~/.vim/  ~/vim_old_lcd/
mv -f ~/.vimrc ~/vimrc_old_lcd

cd ~/ && git clone https://github.com/orientlu/vim.git
mv -f ~/vim ~/.vim
cp ~/.vim/.vimrc ~/

# other setup
cp ~/.vim/other_sh/config/tmux.conf ~/.tmux.conf
sudo cp ~/.vim/other_sh/cp2bin/*  /usr/bin/
cd ~/.vim/other_sh/run/
sudo ./run.sh
cd -

echo "lcddcl start install bundle" > lcdinstall
echo "please wati" >> lcdinstall

vim lcdinstall -c "PlugInstall" -c "PlugClean" -c "q" -c "q"
rm lcdinstall
echo "lcd's vim install finished"
