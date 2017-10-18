sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common

sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
     libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
     libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
     python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

#Optional: so vim can be uninstalled again via `dpkg -r vim`
sudo apt-get install checkinstall

sudo rm -rf /usr/local/share/vim /usr/bin/vim
sudo apt-get remove vim vim-runtime gvim

cd ~
git clone https://github.com/vim/vim
cd vim
git pull && git fetch

#In case Vim was already installed
cd src
make distclean
cd ..

./configure \
--with-features=huge \
--enable-multibyte \
--enable-rubyinterp=yes \
--enable-pythoninterp=dynamic \
--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
--enable-python3interp \
--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
--enable-perlinterp=yes \
--enable-luainterp=yes \
--enable-gui=gtk2 \
--enable-cscope \
--prefix=/usr/local \
--with-x \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--with-compiledby="yourname" \
--enable-fail-if-missing

make VIMRUNTIMEDIR=/usr/local/share/vim/vim80

cd ~/vim
sudo checkinstall
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
