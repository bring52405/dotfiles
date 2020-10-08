set nocompatible
syntax on
filetype indent plugin on
set number
set expandtab
set smarttab
set autoindent
set hidden
au FileType puppet setlocal tabstop=8 expandtab shiftwidth=2 softtabstop=2
"colorscheme torte
set modelines=0		" CVE-2007-2438
set mouse=a
set backspace=2		" more powerful backspacing
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
au BufWrite /private/etc/pw.* set nowritebackup nobackup
let skip_defaults_vim=1
execute pathogen#infect()
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"Syntastic slows VIM down quite a bit for me
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
let g:airline#extensions#tabline#enabled = 1
let mapleader=','
nnoremap <F5> "=strftime('%x %X')<CR>P
inoremap <F5> <C-R>=strftime('%x %X')<CR>
nnoremap gx :!xdg-open <cWORD> &<CR><CR>
