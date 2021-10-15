My personal preferences/settings for VIM.

This applies to both VIM and GVIM.

To "install", simply:
```
cp .vimrc ~
cp .gvimrc ~
mkdir ~/.vim ; cp -R .vim/* ~/.vim/
```

Notes:
* This is prebundling pathogen, maybe not the latest version;
* I also install [syntastic](https://github.com/vim-syntastic/syntastic), to
  have some syntax validation. Also note that the .vimrc is already configured
  to use shellcheck and checkbashisms, if you have them installed;
* This is defaulting to TABs, but you just need to uncomment a line on .vimrc
  to switch to spaces. I use and recommend
  [sleuth](https://github.com/tpope/vim-sleuth) which will make vim
  automagically enter a TAB when editing a TAB-using file, and a space when
  editing a space-using file;
* If you're a git user, installing
  [fugitive](https://github.com/tpope/vim-fugitive) will make your life better.
