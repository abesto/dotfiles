colorscheme koehler
set nu shiftwidth=2 tabstop=8 smartindent backspace=2 fileencoding=utf-8
set incsearch nohlsearch
set guioptions=ic
filetype plugin indent on
syntax on

" FuzzyFinder maps
nmap <Leader>e :FuzzyFinderFile<CR>
nmap <Leader>b :FuzzyFinderBuffer<CR>
nmap <Leader>d :FuzzyFinderBuffer<CR>

" For VIM-LaTeX
set grepprg=grep\ -nH\ $*
let g:tex_flavor="latex"
let g:Tex_DefaultTargetFormat="pdf"

" For php-doc, doxymacs-like format
map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr> 

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 
