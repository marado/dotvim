" .vimrc
"
" By: Marcos Marado
" URL: https://github.com/marado/dotvim/
" Notes: some stuff inspired by cog's .vimrc ( https://github.com/cog/ )

""" SETTINGS

" This must be first, because it changes other options as a side effect.
set nocompatible

set tabstop=4					" adjust as you like. 4 is nice for me.
set shiftwidth=4				" adjust as you like. 4 is nice for me.
set autoindent					" helps
set showmatch					" helps
"set expandtab					" tabs FTW. but not everyone thinks the same...
set ignorecase					" please...
set smartcase					" please...
set incsearch                   " do incremental searching
let &background = "dark"		" background is dark, so don't show dark colors
set backspace=2	                " backspacing over everything in insert mode
set history=1000                " keep 1000 lines of command line history
set ruler	                    " show the cursor position all the time
set ic		                    " ignore case in search patterns
set scs		                    " override 'ic' when pattern has uppers
set showcmd	                    " display incomplete commands
set nobackup	                " do not keep a backup file, use versions instead
set laststatus=2                " always display the status line
set nosol	                    " cursor is kept in the same column (if possible)
set nrformats=  	            " only decimal numbers can be incremented
set matchpairs+=<:>             " Match angle brackets too
set fileformats=unix,mac,dos    " Handle (stupid) Mac and DOS line-endings
set wildmode=list:longest,full  " completions when possible, then iterate
set updatecount=10              " Save buffer every 10 chars typed
set hlsearch                    " Highlight all search matches
let loaded_vimspell = 1			" duh

" give the world some color...
syntax on
highlight Comment        guifg=#80a0ff ctermfg=darkgreen
highlight Search         term=reverse   ctermfg=white   ctermbg=LightGreen
set hls

""" OVERRIDES

" Q for formatting instead of Ex mode
map Q gq                        
" pressing up in a long line gets you to the above line "in the screen", etc.
noremap  j            gj
noremap  k            gk
noremap  <Up>         gk
noremap  <Down>       gj
inoremap <Up>         <C-O>gk
inoremap <Down>       <C-O>gj
" switching between windows in an easier way
map <Tab> <C-W><C-W>
map <C-K> <C-W>k
map <C-J> <C-W>j
map <C-H> <C-W>h
map <C-L> <C-W>l

""" COMMANDS

" my personal help
fu! Helpme()
  echo "Help to Marcos Marado's vim extented funcionalities"
  echo " "
  echo "  ;h       - help"
  echo "  ,,       - sets noautoindent"
  echo "  ,.       - sets autoindent"
  echo "  F4       - syntax colored HTML"
  echo "  F11      - enter \"paste mode\" (toogle)"
  echo "  ;r       - reload .vimrc"
  echo "  F8       - rot13"
  echo "  ;b       - dark / light background"
  echo "  ;n       - numbering / unumbering lines"
  echo "  -        - line wrapping"
  echo "  C-M      - maximize a window"
  echo "  C-N      - make windows equally high and wide"
  echo "  C-G      - make windows equally high and wide (same as C-N)"
  echo "  gw       - swap the current word"
  echo "  < or >   - indent/unident selected lines"
  echo "  C-B      - removes highlight (same as H)"
  echo "  H        - removes highlight (same as C-R)"
  echo "  ;t       - format file with perltidy"
  echo "  #        - toggle comments"
  echo " "
endf

" personalized commands:

" ;h - Help
map <silent> ;h :exe Helpme()<CR>
" set noautoindent
map ,, :set noautoindent<CR>
" set autoindent
map ,. :set autoindent<CR>
" F4 - syntax colored HTML
map <silent> <F4> :runtime! syntax/2html.vim<CR>
" paste mode 
set pastetoggle=<F11>
" ;r - Reload .vimrc (overrides previous options, but does not remove them)
map <silent> ;r :so $HOME/.vimrc<BAR>echo "Reloaded .vimrc"<CR>
" F8 - rot13
map <F8> ggVGg?
" ;b - dark / light background
map ;b :let &background = ( &background == "dark"? "light" : "dark" )<CR>
" ;n - numbering / unumbering lines
map ;n :set invnumber<CR>
" line wrapping
map <silent> - :set invwrap<BAR>echo "wrap is" (&wrap ? "on" : "off")<CR>
" maximize a window
map <C-M> <C-W><Bar><C-W>_<BAR>:echo "Window maximized"<CR>

" make all windows (almost) equally high and wide
map <C-N> <C-W>=<BAR>:echo "All windows equally sized"<CR>

" reverse status bar colors (useful when working with several windows)
:hi StatusLine   ctermfg=white term=reverse cterm=reverse gui=reverse
:hi StatusLineNC ctermfg=blue  term=reverse cterm=reverse gui=reverse

" make search results appear in the middle of the screen
nmap n  nzz
nmap N  Nzz
nmap *  *zz
nmap #  #zz
nmap g* g*zz
nmap g# g#zz

" allow the . to execute once for each line of a visual selection
vnoremap . :<C-U>execute "'<,'>g/^/norm!" . virtcol("'<") . "\|."<CR><BAR>:noh<CR>

" type gw to swap the current word and the next one (english alphabet only)
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>

" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" some common typos
command! Qa qa
command! Q  q
command! W  w
command! Wq wq

" <C-B> removes highlight
map <silent> <C-B> :noh<CR>
map H :nohlsearch<CR>

" syntax highlighting on, when the terminal has colors
" also switch on highlighting the last used search pattern.
if &t_Co > 2||has("gui_running")
syntax on
set hlsearch
endif

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78
" ...but if it is a git commit, stick to 70.
autocmd FileType gitcommit setlocal textwidth=70

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$")|
\ exe "normal g`\""|
\ endif

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

" Virtual edit lets you move your cursor move to it usually would not
" In it's 'block' mode, you can only do that in visual mode
set virtualedit=block

" Format file with perltidy...
nnoremap <silent> ;t :%!perltidy -q<cr>
vnoremap <silent> ;t :!perltidy -q<cr>


" " Mason code is now highlighted
" au syntax mason so /usr/share/vim/vim63/syntax/mason.vim
" au BufNewFile,BufRead *.mas set ft=mason
" au BufNewFile,BufRead *.mc set ft=mason

" HTMLize
" so $HOME/.vim/html_iso_8859_portugues.vim
" so $HOME/.vim/html_utf8_portugues.vim

" syntastic
execute pathogen#infect()
let g:syntastic_sh_checkers = ['shellcheck', 'checkbashisms', 'sh']
let g:syntastic_sh_shellcheck_args="-x"
