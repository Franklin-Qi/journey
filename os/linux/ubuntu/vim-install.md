# How to Install Vim on Ubuntu
I hope this quick little tutorial helped you to install Vim on Ubuntu and make it the default text editor.
[Install Vim](https://linuxhandbook.com/install-vim-ubuntu/)

# Install Vim on Ubuntu
sudo apt install vim

# Make Vim the default editor in Ubuntu
```
sudo update-alternatives --config editor
```

The Vim that you know and love to use is Vim Basic. That Vim tiny is a stripped down version of Vim and 
you may not get all the Vim features in it. To avoid bad surprises, go with Vim basic.

In my case, if I enter 3, Vim basic will become the default text editor. If you want to revert it, you can repeat the steps.

## vim color 
[solarized](https://github.com/altercation/vim-colors-solarized)

## vim vundle manager
[vunble](git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim)
[知乎](https://zhuanlan.zhihu.com/p/22245538)

## vim non-chinese
:%s/\v[^\x00-\xff]+//g
