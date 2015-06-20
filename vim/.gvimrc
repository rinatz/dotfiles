" window sizes
set lines=30
set columns=120

" show horizontal bar
set guioptions+=b

" font
if has('win32')
    set guifont=Inconsolata:h12:cSHIFTJIS
    set guifontwide=IPAGothic:h12:cSHIFTJIS
else
    set guifont=Inconsolata\ 12
    set guifontwide=TakaoGothic\ 12
endif

" color
colorscheme molokai
let g:molokai_original=1
