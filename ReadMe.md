# Doogie's dotfiles

현재 문제점: linux에서 tmux 로 들어가면 vim 의 color scheme 이 달라진다. 왜 그런지는 모름

구현 안된 부분: 

* mac 에서 brew 를 깔고 brew install reattach-to-user-namespace 실행 하도록 하자, Ubuntu 의 경우 xclip 을 깔아야 함
* mac 이랑 linux 에서 reattach-to-user-namespace 때문에 tmux.conf 에서 수동으로 comment-out 해야 하는 부분이 있음
이 부분을 자동화 하자

ctag 의 경우 ubuntu 에서는 build 해야 하므로

* sudo apt-get install autoconf 

를 통해 autoconf 를 설치하고, ctags dir 로 들어가서 make 해주어야 한다.

* vim 8.0 을 설치해야 gruvbox 를 제대로 사용 가능, 또한 mac 의 경우 iterm2 를 사용해 주어야만 한다.
* 설치해야 하는 파일들을 script 로 만들어서 설치시에 scala 로 설치하게 하면 좋을듯 
