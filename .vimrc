syntax on 
set number 
set tabstop=8
set shiftwidth=4
set expandtab
set softtabstop=4
set smartcase
set hlsearch
set ignorecase

inoremap jk <esc>

:nnoremap \n :setlocal number!<cr>

if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal! g'\"" | endif
endif

set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

filetype plugin on
filetype indent plugin on

set autochdir
set tags=tags;

set wildmode=longest,list,full
set wildmenu

if &diff
    colorscheme delek
endif

"set cursorline
hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkred guifg=white
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_switch_buffer = 'Et'

"set mouse=n
"set mousefocus 

"taglist
nnoremap <silent> <C-t> :TlistToggle<CR>
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1

:cnoreabbrev vh vert help
:cnoreabbrev vt vertical term

"tabline
if exists("+showtabline")
     function! MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%1*' : '%2*')
             let s .= ' '
             let s .= '|' . i . ')'
             let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             let s .= ' '
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif


"for weird ctags
nnoremap <c-]> g<c-]>

:set shell=/home/weibing/bin/zsh

"auto complete braket{
"inoremap {<CR> {<CR>}<Esc>ko<tab>

set grepprg=grep\ --color=auto\ --exclude-dir={.bzr,CVS,.git,.hg,.svn}\ -nr\ --include=\\*.{cc,h,hpp,cpp,py}\ $*\ /home/weibing/SourceCode/Git/Salt/Development/salt/src/
command! -nargs=+ Grp execute 'silent! grep <args> ' | redraw! | copen 15
command! Grep execute 'silent! grep '.expand("<cword>") | redraw! |  copen 15
