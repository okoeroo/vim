sy on
set bg=dark
set wrap
set hlsearch

" set autoindent
set smartindent

set shiftwidth=4
set tabstop=8
set softtabstop=4
set expandtab

set cscopetag

set ruler       " show cursor position
set incsearch   " incremental search - shows results while typing
"set ignorecase  " match any string case in search
set smartcase   " smart case matching

set showmatch   " show matching parentheses
set showcmd     " show command

" set sidescrolloff=10 " Keep 5 lines at the size

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 


if has("autocmd")
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

    " High light tabs and spaces until EOL
    autocmd syntax * SpaceHi
endif 


" set cmdheight=10


syntax match Tab /\t/
hi Tab gui=underline guifg=blue ctermbg=blue 

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

map <F4> ofor(i=0; i < ; i++) <ESC>o{<ESC>o}<ESC>kI<ESC>f;a<SPACE>
map! <F4> for(i; i < ; i++) <ESC>o{<ESC>o}<ESC>kI<ESC>f;a<SPACE>
map <F5> owhile() <ESC>o{<ESC>o}<ESC>kI<ESC>f(a
map! <F5> while() <ESC>o{<ESC>o}<ESC>kI<ESC>f(a
map <F6> oif() <ESC>o{<ESC>o}<ESC>oelse<ESC>o{<ESC>o}<ESC>kf(a
map! <F6> if() <ESC>o{<ESC>o}<ESC>oelse<ESC>o{<ESC>o}<ESC>kf(a

map <F7> oswitch() <ESC>o{<ESC>ocase:<CR>break;<CR>case:<CR>break;<CR>default:<CR>}<ESC>6kf(a
map! <F7> switch() <ESC>o{<ESC>ocase:<CR>break;<CR>case:<CR>break;<CR>default:<CR>}<ESC>6kf(a


map ,^ :s/^\(.*\)\n[    ]\+\([^     ].*$\)/\1 \2/gc<CR>y<CR>:nohlsearch<CR>


" , #perl # comments
map ,# :s/^/#/<CR>

" ,/ C/C++/C#/Java // comments
map ,/ :s/^/\/\//<CR>

" ,< HTML comment
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

" c++ java style comments
map ,, :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>

" c++ java style comments
map ,* :s/^\(\s*\)\(\p*\)$/\1\/\* \2 \*\//<CR><Esc>:nohlsearch<CR>

" Smart way to move btw. windows
map ` <C-W>w
map § <C-W>w
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

noremap <s-w> <C-y>
noremap <s-s> <C-e>

fun! ReadMan()
  " Assign current word under cursor to a script variable:
  let s:man_word = expand('<cword>')
  " Open a new window:
  :exe ":wincmd n"
  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":r!man " . s:man_word . " | col -b"
  " Goto first line...
  :exe ":goto"
  " and delete it:
  :exe ":delete"
endfun
" Map the K key to the ReadMan function:
map K :call ReadMan()<CR>

" Set my TabStop settings
command! -nargs=* OscarTab call OscarTab()
function! OscarTab()
    let &l:sts = 4
    let &l:ts = 4
    let &l:sw = 4
    let &l:et = 1
    call SummarizeTabs()
endfunction

" Set Mischa's TabStop settings
command! -nargs=* MischaTab call MischaTab()
function! MischaTab()
    let &l:sts = 8
    let &l:ts = 8
    let &l:sw = 4
    let &l:et = 0
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
    try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
    echon ' expandtab'
    else
    echon ' noexpandtab'
    endif
    finally
    echohl None
    endtry
endfunction

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.c :call DeleteTrailingWS()
"autocmd BufWrite *.cc :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.sh :call DeleteTrailingWS()

