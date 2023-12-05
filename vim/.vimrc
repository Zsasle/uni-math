set visualbell
set t_vb=
syntax on
filetype plugin indent on
colorscheme gadse

execute pathogen#infect()
let g:UltiSnipsExpandTrigger		= '<c-j>'
let g:UltiSnipsJumpForwardTrigger	= '<c-j>'
let g:UltiSnipsJumpBackwardTrigger	= '<c-k>'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" ino ( ()<Left>
" ino [ []<Left>
" ino { {}<Left>
" ino {<CR> {<CR>}<ESC>O
