set nu
set t_ut=
set t_Co=256
set background=dark
colorscheme gruvbox

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = 50
let g:netrw_preview = 1
let g:netrw_banner = 0
let g:netrw_altv = 1
set splitright
set autochdir

fun! Sidebar()
	if exists("t:lex_opened") && (t:lex_opened)
		execute "Lexplore"
		let t:lex_opened = 0
	else
		execute "Lexplore " . getcwd() 
	       	execute "vertical resize 25"
		let t:lex_opened = 1
		set winfixwidth
		set winfixheight
	endif

	execute "winc ="
endf

fun! SizeEvenly()
	if exists("t:lex_opened") && (t:lex_opened)
		execute "winc ="
	endif
endf

augroup NetrwGroup
      autocmd! BufEnter * execute SizeEvenly()
augroup END

map <C-c> :call Sidebar()<cr>
vnoremap . :normal . <cr>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplete#enable_at_startup = 1
set completeopt-=preview

set fillchars+=vert:\ 

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
call vundle#end()

filetype plugin indent on
