#/bin/sh
tar -zxvf ./bundle.tar.gz
if [ ! -d "~/.vim/"]; then 
mkdir ~/.vim
fi
cp ./vimrc ~/.vimrc
cp -rf ./* ~/.vim/.
rm ~/.vim/vimrc


