#! /bin/bash

COLOR_NONE="\033[0m"
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_WHITE="\033[1;37m"


install_essential_packages() {
    local -a packages; packages=( \
        curl htop silversearcher-ag xclip \
        )

    sudo apt-get install -y ${packages[@]}
}

install_python_packages() {
    sudo apt-get install -y python3-dev python3-pip python-virtualenv

    # install recent versions (9+) of pip at /usr/local/bin
    sudo /usr/bin/pip3 install --upgrade pip        # pip3
}

install_ppa_git() {
    # https://launchpad.net/~git-core/+archive/ubuntu/ppa
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get install -y git-all git-extras
}

install_ppa_vim8() {
    # For Ubuntu 14.04 and 16.04
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get install -y vim
}

install_neovim() {
    # https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim

    command -v /usr/bin/pip3 2>&1 > /dev/null || sudo apt-get install -y python3-pip
    sudo /usr/bin/pip3 install --upgrade neovim
} 

install_latest_tmux() {
    # Steps to build and install tmux from source on Ubuntu.
    # Takes < 25 seconds on EC2 env [even on a low-end config instance].
    VERSION=2.5
    sudo apt-get -y remove tmux
    sudo apt-get -y install wget tar libevent-dev libncurses-dev
    wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
    tar xf tmux-${VERSION}.tar.gz
    rm -f tmux-${VERSION}.tar.gz
    cd tmux-${VERSION}
    ./configure
    make
    sudo make install
    cd -
    sudo rm -rf /usr/local/src/tmux-*
    sudo mv tmux-${VERSION} /usr/local/src
    ## Logout and login to the shell again and run.
    ## tmux -V
}

install_all() {
    install_essential_packages
    install_python_packages
    install_latest_tmux
    install_ppa_vim8
    install_neovim
    install_ppa_git
}

# entrypoint script
if [ `uname` != "Linux" ]; then
    echo "Run on Linux (not on Mac OS X)"; exit 1
fi
if [ -n "$1" ]; then
    $1
else
    echo "Usage: $0 [command], where command is one of the following:"
    declare -F | cut -d" " -f3 | grep -v '^_'
fi
