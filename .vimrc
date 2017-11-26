" enable pathogen vim plugin manager
syntax on 
execute pathogen#infect()
filetype plugin indent on

" enable syntax highlighting and solarized color scheme
set background=dark
colorscheme solarized

set tabstop=2
set shiftwidth=2
set expandtab
set number
set relativenumber

set nocompatible              " be iMproved, required
filetype on

" ctrl-P ignore files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
