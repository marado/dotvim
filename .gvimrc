" Configuration file for gvim

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty
" Switch syntax highlighting on, when the terminal has colors

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Set background light for gvim
set background&

" Also switch on highlighting the last used search pattern.
if has("syntax") && (&t_Co > 2 || has("gui_running"))
  syntax on
  set hlsearch
endif

" Extensions by i18n teams
if filereadable( "/etc/vim/langrc/" . $LANG . ".vim" )
   exe "so " . "/etc/vim/langrc/" . $LANG . ".vim"
endif

set guifont=Monospace\ 14

if filereadable("/etc/vim/gvimrc.local")
  source /etc/vim/gvimrc.local
endif

colorscheme ron
