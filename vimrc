" Set C syntax options
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" utility
set nocompatible
set foldmethod=manual
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize = 30
filetype on
filetype plugin on
filetype indent on
set shiftwidth=2
set tabstop=2
set expandtab
set incsearch
set path+=**
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,*.o,*.d,*.out
set noshowcmd
set laststatus=2

" appearance
set rnu
set colorcolumn=80
colorscheme gruvbox
syntax on

" lsp

" hide warning popups
"let g:lsp_diagnostics_enabled = 0
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
    augroup end
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END



" auto mappings
augroup tex_mappings
  autocmd FileType tex nnoremap <buffer> <leader>m :term ++shell ++close pdflatex *.tex<CR>
  autocmd FileType tex set scrolloff=20
augroup END

augroup cc_mappings
  autocmd FileType cpp map <buffer> <leader>e :term ++shell make<CR>
  autocmd FileType cpp map <buffer> <leader>m :term ++shell ++close make<CR>
  autocmd FileType h map <buffer> <leader>m :term ++shell ++close make<CR>
  autocmd FileType cpp noremap <buffer> <leader>r :vertical term<CR>make run<CR>
augroup END

augroup c_mappings
  autocmd FileType c set syntax=cpp
  autocmd FileType c map <buffer> <leader>e :term ++shell make<CR>
  autocmd FileType c map <buffer> <leader>q :!echo test<CR>
  autocmd FileType c map <buffer> <leader>m :term ++shell ++close make<CR>
  autocmd FileType h map <buffer> <leader>m :term ++shell ++close make<CR>
  autocmd FileType c noremap <buffer> <leader>r :vertical term<CR>make run<CR>
  autocmd FileType c noremap <buffer> <leader>S :term ++shell ++close make assemble<CR>
  autocmd FileType c noremap <buffer> <leader>s :tabnew main.s<CR>
  "autocmd FileType c noremap <buffer> <leader>r :! make run<CR>
augroup END

augroup hs_mappings
  autocmd FileType hs map <buffer> <leader>e :term ++shell make<CR>
  autocmd FileType hs noremap <buffer> <leader>r :vertical term<CR>make run<CR>
  autocmd FileType hs map <buffer> <leader>m :term ++shell ++close make<CR>
augroup END

" mappings
let mapleader = " "
noremap <leader><C-s> :so $MYVIMRC<CR>
noremap <leader>v :tabnew $MYVIMRC<CR>
map <leader>o o\[\]<C-c>hi
map <leader>O O\[\]<C-c>hi
map <leader>b o\bbox<CR>\begin{(++)}<CR><++><CR>\end{(++)}<CR>\ebox<CR><Esc>kkkV=kkk/(++)<CR>cab
map <leader>B n.?<++><CR>ca<
map <leader>z :term ++close ++shell zathura --fork *.pdf<CR>
map <leader>g /<++><CR>
map <leader>J gJhhdf[
map <leader>f :Vex .<CR>
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l
imap <C-e> \(\)<C-o>h

"echo "SOURCED!"
