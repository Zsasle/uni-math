set visualbell
set t_vb=
" Only do this part when compiled with support for autocommands
if has("autocmd")
	augroup redhat
	autocmd!
	" When editing a file, always jump to the last cursor position
	autocmd BufReadPost *
	\	if line("'\"") > 0 && line ("'\"") <= line("$") |
	\		exe "normal! g'\"" |
	\	endif
	augroup END
endif

syntax on
filetype plugin indent on
colorscheme gadse

set showcmd

set undofile
set undolevels=1000
set undoreload=10000

set backup
set swapfile
set undodir=~/.vim/temp/undo
set backupdir=~/.vim/temp/backup
set backupskip=~/.vim/temp/*
set directory=~/.vim/temp/swap
set writebackup

if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

execute pathogen#infect()
let g:UltiSnipsExpandTrigger		= '<c-j>'
let g:UltiSnipsJumpForwardTrigger	= '<c-j>'
let g:UltiSnipsJumpBackwardTrigger	= '<c-k>'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" ino ( ()<Left>
" ino [ []<Left>
" ino { {}<Left>
" ino {<CR> {<CR>}<ESC>O
