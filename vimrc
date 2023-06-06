" vim: set fdm=marker:

" Bypass vimrc or load alternate vimrc
" vim -u NONE
" vim -u ~/vimrc-alternate

" Check/Debug settings
" set modeline?
" verbose set modeline? modelines?


" --------------------------------------------------
" vim-plug
" --------------------------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'itchyny/lightline.vim'
    Plug 'preservim/tagbar'
    Plug 'vim-scripts/DrawIt'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'altercation/vim-colors-solarized'
    Plug 'godlygeek/tabular'
    Plug 'andymass/vim-matchup'
    Plug 'vim-scripts/gtags.vim'
    Plug 'tpope/vim-fugitive'
call plug#end()


" --------------------------------------------------
" UI Behavior
" --------------------------------------------------
set nocompatible                " No original vi's bugs and limitations.
set nobackup		            " do not keep a backup file ending with "~" character
set history=50		            " keep 50 lines of command line history
set showcmd		                " display partial commands in the last line
set noshowmode                  " because it is now provided by the status line
set hidden                      " dont prompt to save changes 
set timeout                     " turn on timing out on mappings and key codes
set timeoutlen=4000             " wait 4 seconds for all keys in a mapping to be pressed.
set ttimeoutlen=100             " timeout on key codes after 10th of a second.
set guioptions-=T               " No GUI toolbar
set guioptions+=b               " show bottom scroll bar

" color scheme
colorscheme solarized
set background=dark
augroup autoUI
    autocmd!
    autocmd VimResized * wincmd =  " auto splits equilzation
augroup END

" Macvim font
if has("mac") || has("macunix")
    set guifont=Monaco\ for\ Powerline:h14
endif

" --------------------------------------------------
" Editor Behavior
" --------------------------------------------------
if exists('+relativenumber')
    set relativenumber
endif
syntax on                       " Turn on syntax highlighting
set number
set backspace=indent,eol,start  " backspace dels autoindents, end of lines
set splitright                  " new vert splits appears on the right
set splitbelow                  " new vert splits appears below the current window
set autowrite                   " automatically save files when changing buffers
set scrolloff=2                 " Two lines of context visible around the cursor at all times.
set wildmenu                    " show some autocomplete options in status line
set wildignore+=*.lib,*.o,*.obj " ignore filetypes for auto complete
set wildmode=list:longest       " list all mathces and complete till logest common
set nowrap
set autoread					" reload file if changed outside vim but not in vim
augroup autoEdit
    autocmd!
    autocmd CursorHold * silent! checktime     " auto reload if no cursor movement

    autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif                            " Jump to last known cursor position
augroup END

                                          
                                               
" --------------------------------------------------
" indentation
" --------------------------------------------------
filetype plugin indent on       " autoload language specific indentation file
set autoindent		            " copy indent from prev line. set paste turns if off
set cindent                     " Context base indenting for C-code
set cino=l1                     " Allign with case label
set tabstop=4                   " 4-space tabs
set shiftwidth=4                " autoindent setting
set expandtab                   " convert tab to spaces
set softtabstop=4               " backspace key treat four spaces like a tab


" --------------------------------------------------
" search
" --------------------------------------------------
set nohls                       " Don't highlight search matches
set ignorecase                  " ignore case if search pattern is all in lower-case
set smartcase                   " override ignorecase if uppercase letters typed
set incsearch		            " do incremental searching
set infercase                   " don't ignore case in completions

" --------------------------------------------------
" Clipboard
" --------------------------------------------------
set clipboard=unnamedplus      " share clipboard with X11 clipboard
set clipboard+=unnamed          " share clipboard with windows clipboard


" ------------------------------------------------
" Mouse support
" ------------------------------------------------
" set ttymouse=xterm2
" set mouse=n
" set mouse=a                   " mouse does not select line numbers but create problem with 'y' copying to clipboard


" ------------------------------------------------
" My Mappings
" ------------------------------------------------
let mapleader=","
let maplocalleader="\\"

inoremap jk <ESC>

" window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-p> :FZF<CR>

" Leader 
set wildcharm=<C-z>
nnoremap <leader>b :buffer<Space><C-z>|                             " invoke :buffers and list the available buffers
nnoremap <Leader>h :cs f f %:t:r.h<CR>|                             " cscope Go to .h file
nnoremap <Leader>c :cs f f %:t:r.c<CR>|                             " cscope Go to .c file  
nnoremap <Leader>f :cs f f |                                        " cscope find file
nnoremap <Leader>g :cs f g |                                        " cscope find symbol
nnoremap <Leader>n :set nonumber<CR> :set norelativenumber<CR>|     " disable all numbering
nnoremap <Leader>t :TagbarToggle<CR>|                               " Tagbar


map <F3> :set paste!<CR>:startinsert<CR>|                           " Normal mode -> Paset+Insert mode
set pastetoggle=<F3>                                                " F3 toggles in and out of paste mode

nmap <F4> :cn<CR>

"Search for selected text, forwards 
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"Search for selected text, backwards.
vnoremap <silent> # :<C-U>  
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


" move line up/down
noremap - ddp
noremap _ ddkP

" uppercase
inoremap <c-u> <esc>viwUi
nnoremap <c-u> viwU<esc>

" wrap text
" must press enter after <leader>" because of confusion with <leader>""
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel  
noremap <leader>"" <esc>a"<esc>`<i"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" vimrc editing
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"previous buffer
nnoremap <leader>pb :execute "rightbelow vsplit " . bufname("#")<cr>

" insert semicolon at the end of line
nnoremap <leader>; :normal! mqA;<esc>`q <cr>


" map ha 'hex address' convert lines of the form 'addr-451ab906-95e2' to 'addr-69.26.185.6-38370'
nnoremap <leader>ha :s/addr-\(..\)\(..\)\(..\)\(..\)-\([a-f0-9]\{3,4\}\)/\=printf("addr-%d.%d.%d.%d-%d",str2nr(submatch(1),16), str2nr(submatch(2),16),str2nr(submatch(3),16),str2nr(submatch (4),16),str2nr(submatch(5),16))/ <CR><CR>


" ------------------------------------------------
" Abbreviations
" ------------------------------------------------
iabbrev waht what
iabbrev tehn then
iabbrev adn  and



" ------------------------------------------------
" Filetype specific
" ------------------------------------------------

" .sml is not Standard ML
augroup sml_ft
    autocmd!
    autocmd BufNewFile,BufRead *.sml set filetype=c syntax=c
augroup END

augroup fileType
    autocmd!
    autocmd FileType c,cpp,java,scala noremap <buffer> <localleader>c :normal! I//<CR>
    autocmd FileType sh,ruby,python   noremap <buffer> <localleader>c :normal! I#<CR>
    autocmd FileType vim              noremap <buffer> <localleader>c :normal! I"<CR> 
    autocmd Filetype sh               let b:is_bash=1
augroup END



" ------------------------------------------------
" Cscope
" ------------------------------------------------
if has ("cscope")
    " instead of showing cscope results in the current window
    " put them in the quickfix window then use :cn :cp to jump
    " :cl to see all and :cc [nr] to jump to [nr]
    set csqf=s-,c-,d-,i-,t-,e-

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    "hit 'CTRL-\', followed by one of the cscope search types above (s,g,c,t,e,f,i,d)
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  
endif


" ------------------------------------------------
" My commands
" ------------------------------------------------

function! Appinfofix()
    let pos = search("NAT lookup dst key is copied:", "W")
    while(pos)
        let mylst = []
        for i in range(pos+1,pos+5)
            call add(mylst, matchstr(getline(i), '    .\+$'))
            let line = join(mylst, "")
            let line = substitute(line, '[ .]\+', "", "g")
            let line = "dst key added - " . line
            call setline(pos, line)
        endfor
        let pos = search("NAT lookup dst key is copied:", "W")
    endwhile
endfunction


function! Scratch()
    exec winheight(0)/4."split"
    noswapfile enew                 "noswapfile {command}, run command without creating a swapfile
    setlocal buftype=nowrite
    setlocal bufhidden=wipe
    setlocal buftype=nofile
    file __scratch__                "set name of current file
endfunction

function! Ref(file)
    exec winheight(0)/5."split".a:file
endfunction



" diff between current buffer and the file it was opened from
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


" Adds offsets to SIP:Received output in packetdiag log.
" Place cursor on first line of payload and run :call Add_offset(1448),
" where 1448 is the offset of the first byte, obtained from tcp seq output
function! Add_offset(start)
    let pos = getpos('.')[1]
    let endpos = search('^-\+$')
    let offst = a:start
    for i in range(pos,endpos-1)
        let line = getline(i)
        call setline(i, printf("%5d 0x%04x %s",offst,offst, line))
        let offst = offst + strdisplaywidth(line)
    endfor
endfunction
        

" ------------------------------------------------
" Lightline
" ------------------------------------------------
" Requires: tagbar, set laststatus=2, powerline fonts provided by iterm2

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'tagbar' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], ['byteofset'], ['charvalhex']  ] 
      \ },
      \ 'component': {
      \     'tagbar': '%{tagbar#currenttag("%s", "", "f")}', 'charvalhex': '0x%B', 'byteofset':'%o'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }




" ------------------------------------------------
" Tagbar
" ------------------------------------------------
let g:tagbar_autoclose = 1


" ------------------------------------------------
" NETRW
" ------------------------------------------------
let g:netrw_preview   = 1       " vertical splitting is default for previewing
let g:netrw_liststyle = 3       " default listing style is tree
let g:netrw_winsize   = 30      " directory listing will use 30% of available columns


" ------------------------------------------------
" Gtags
" ------------------------------------------------
set csprg=gtags-cscope
cs add GTAGS



