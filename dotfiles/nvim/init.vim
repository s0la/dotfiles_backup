set nu
set t_ut=
set t_Co=256
set mouse=""
set termguicolors
set background=dark
"let &colorcolumn=join(range(100,999),",")
"colorscheme flatlandia
colorscheme despacio

"hi ColorColumn guibg=#26292c
"hi Braces guibg=white
"highlight MatchParen cterm=bold ctermfg=cyan ctermbg=black
let loaded_matchparen = 1
"let g:loaded_matchparen=1
"let s:paren_hl_on = 0

"autocmd VimEnter * hi Normal guibg=#2d3033
"autocmd VimEnter * hi NonText guibg=#26292c

set laststatus=2
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'flatlandia'
let g:airline_theme = 'base16_grayscale'

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
tnoremap <Esc> <C-\><C-n>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#enable_at_startup = 1
set completeopt-=preview

set fillchars+=vert:\ 

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'shougo/deoplete.nvim'
Plugin 'jordwalke/flatlandia'
call vundle#end()

filetype plugin indent on

let g:terminal_color_0  = '#4C4C4C'
let g:terminal_color_1  = '#545454'
let g:terminal_color_2  = '#875651'
let g:terminal_color_3  = '#8F995C'
let g:terminal_color_4  = '#7D874A'
let g:terminal_color_5  = '#8F995C'
let g:terminal_color_6  = '#8F995C'
let g:terminal_color_7  = '#6B6B6B'
let g:terminal_color_8  = '#4C5359'
let g:terminal_color_9  = '#875651'
let g:terminal_color_10 = '#8F995C'
let g:terminal_color_11 = '#756958'
let g:terminal_color_12 = '#667D80'
let g:terminal_color_13 = '#8C696F'
let g:terminal_color_14 = '#6B6B6B'
let g:terminal_color_15 = '#6B6B6B'
