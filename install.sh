#/bin/sh
tar -zxvf ./bundle.tar.gz
mkdir ~/.vim
cp ./vimrc ~/.vimrc
cp ./autoload/* ~/.vim/.
cp ./bundle/* ~/.vim/.
cp ./colors/* ~/.vim/.


