colorscheme desert
set nu shiftwidth=4 tabstop=8 smartindent backspace=2 fileencoding=utf-8
set incsearch wildmenu nohlsearch
set guioptions=ic
filetype plugin indent on
syntax on

set cursorline

" FuzzyFinder maps
nmap <Leader>e :FuzzyFinderFile<CR>
nmap <Leader>b :FuzzyFinderBuffer<CR>
nmap <Leader>d :FuzzyFinderBuffer<CR>

" For VIM-LaTeX
set grepprg=grep\ -nH\ $*
let g:tex_flavor="latex"
let g:Tex_DefaultTargetFormat="pdf"
