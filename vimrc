" --------------------------------------------------
" Table of Contents
" --------------------------------------------------
"  1  vim_plug
"  2  Plugins to try later
"  3  UI_Behavior
"  4  Editor Behavior
"  5  indentation
"  6  search
"  7  Clipboard
"  8  Mouse_support
"  9  My_Mappings
"       - Key Mappings
"       - Leader Mappings
" 10  Abbreviations
" 11  Filetype_specific
" 12  Cscope
" 13  PAN_commands
" 14  My_commands
" 15  Optional_packages
" 16  Lightline
" 17  Tagbar
" 18  NETRW
" 19  Gtags
" 20  Vim_Matchup


" --------------------------------------------------
" vim_plug
" --------------------------------------------------
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')
        Plug 'itchyny/lightline.vim'
        Plug 'preservim/tagbar'
        Plug 'vim-scripts/DrawIt'
        Plug '~/Tools/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'altercation/vim-colors-solarized'
        Plug 'godlygeek/tabular'
        Plug 'andymass/vim-matchup'
        Plug 'vim-scripts/gtags.vim'
        Plug 'tpope/vim-fugitive'
        Plug 'chrisbra/csv.vim'
        Plug 'tpope/vim-speeddating'
        Plug 'ConradIrwin/vim-bracketed-paste'
        Plug 'will133/vim-dirdiff'
        Plug 'tpope/vim-commentary'
    call plug#end()
else
endif


" --------------------------------------------------
" Plugins to try later
" --------------------------------------------------
" Plug 'jceb/vim-orgmode'
" Plug 'inkarkat/vim-SyntaxRange'     ranges in file with different syntax


" --------------------------------------------------
" UI_Behavior
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

" Load color scheme, do nothing if colorscheme not present
try
    set background=dark
    let g:solarized_termcolors=256
    let g:solarized_contrast = "high"
    colorscheme solarized
catch 
endtry

" Make the size of splits equal when window is resized
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
" Mouse_support
" ------------------------------------------------
" set ttymouse=xterm2
" set mouse=n
" set mouse=a                   " mouse does not select line numbers but create problem with 'y' copying to clipboard


" ------------------------------------------------
" My_Mappings
" ------------------------------------------------

" use C-z for auto completion in macros 
set wildcharm=<C-z>

"* 
"*  ---- Key Mappings ----
"*
inoremap jk <ESC>

" window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-p> :GFiles<CR>

" Go from Normal mode to Paset+Insert mode
"map <F3> :set paste!<CR>:startinsert<CR>|                           

" F3 toggles in and out of paste mode
set pastetoggle=<F3>     

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

" select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'


"* 
"*  ---- Leader Mappings ----
"*
let mapleader=","
let maplocalleader="\\"

nnoremap <silent><leader>l :Buffers<CR>
nnoremap <Leader>h :cs f f %:t:r.h<CR>
nnoremap <Leader>c :cs f f %:t:r.c<CR>|                             " cscope Go to .c file  
nnoremap <Leader>f :cs f f |                                        " cscope find file
nnoremap <Leader>g :cs f g |                                        " cscope find symbol
nnoremap <Leader>n :set nonumber<CR> :set norelativenumber<CR>|     " disable all numbering
nnoremap <Leader>t :TagbarToggle<CR>|                               " Tagbar

" uppercase
inoremap <leader>u <esc>viwUi
nnoremap <leader>u viwU<esc>

" wrap text
" must press enter after <leader>" because of confusion with <leader>""
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel  
nnoremap <leader>"" <esc>a"<esc>`<i"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" vimrc editing
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"previous buffer
nnoremap <leader>pb :execute "rightbelow vsplit " . bufname("#")<cr>

" insert semicolon at the end of line
nnoremap <leader>; :normal! mqA;<esc>`q <cr>

" draw a 70 character long divider
nnoremap <leader>br o<esc>70i-<esc>j0


" ------------------------------------------------
" Abbreviations
" ------------------------------------------------
iabbrev waht what
iabbrev tehn then
iabbrev adn  and



" ------------------------------------------------
" Filetype_specific
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
    autocmd FileType python           setlocal commentstring=#\ %s
    autocmd FileType vim              noremap <buffer> <localleader>c :normal! I"<CR> 
    autocmd Filetype sh               let b:is_bash=1
    autocmd Filetype yaml             set shiftwidth=2
    autocmd FileType apache           setlocal commentstring=#\ %s
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
" From :h using-xxd
" vim -b : edit binary using xxd-format!
" Changes should be made on the left-hand side of the display (the hex numbers), 
" changes to the right-hand side (printable representation) are ignored on write.
" ------------------------------------------------
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END



" ------------------------------------------------
" PAN_commands
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

" custom vim command to convert lines of the form 'addr-451ab906-95e2' to 'addr-69.26.185.6-38370'
command HexAdr2Dec %s/addr-\(..\)\(..\)\(..\)\(..\)-\([a-f0-9]\{3,4\}\)/\=printf("addr-%d.%d.%d.%d-%d",str2nr(submatch(1),16), str2nr(submatch(2),16),str2nr(submatch(3),16),str2nr(submatch (4),16),str2nr(submatch(5),16))/


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


"
" Replace conflicting flow in the line 'Duplicate flows detected ...'
" with session-id(0/1), where 0 means c2s and 1 s2c
command DupFlow2Sess %s#\(Duplicate flows detected while inserting \d\+, flow\) \(\d\+\) \(.*$\)#\=printf("%s %d(%d) %s", submatch(1),submatch(2)/2,submatch(2)%2,submatch(3))#

" ------------------------------------------------
" My_commands
" ------------------------------------------------

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



" ------------------------------------------------
" Optional_packages
" ------------------------------------------------
" check loaded plugins with :set runtimepath
" machit.vim is found under '/usr/local/Cellar/macvim/9.0.0065/MacVim.app/Contents/Resources/vim/runtime/macros'
" Note: matchit is not needed when 'vim-matchup' plugin is installed.
" packadd! matchit

" debugging with gdb
packadd! termdebug


" ------------------------------------------------
" Lightline
" ------------------------------------------------
" Requires: tagbar, set laststatus=2, powerline fonts provided by iterm2
function! LightlineCurrentTag()
    try 
        return tagbar#currenttag("%s", "", "f")
    catch
        return ""
    endtry
endfunction

" zero based byteoffset, first byte index is zero
function! Byteofset_z()
    let pos = line2byte(line( "." )) + col(".") - 2
    return pos >= 0? pos . '(' . printf("0x%x", pos) . ')': "0(0x0)"
endfunction

if exists("g:plugs") && has_key(plugs, 'lightline.vim')
    set laststatus=2
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'readonly', 'filename', 'modified', 'current_tag' ] ],
          \   'right': [ [ 'lineinfo' ], [ 'percent' ], ['byteofset', 'charvalhex']  ] 
          \ },
          \ 'component_function': {
          \    'current_tag': 'LightlineCurrentTag',
          \    'byteofset': 'Byteofset_z',
          \    'byteHexofset': 'ByteHexOfset_z'
          \ },
          \ 'component': {
          \    'charvalhex': '0x%02B',
          \ },
          \ 'separator': { 'left': '', 'right': '' },
          \ 'subseparator': { 'left': '', 'right': '' }
          \ }
endif


" ------------------------------------------------
" Tagbar
" ------------------------------------------------
if exists("g:plugs") && has_key(plugs, 'tagbar')
    let g:tagbar_autoclose = 1
endif


" ------------------------------------------------
" NETRW
" ------------------------------------------------
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30


" ------------------------------------------------
" Gtags
" ------------------------------------------------
if exists("g:plugs") && has_key(plugs, 'gtags.vim')
    set csprg=gtags-cscope
    cs add GTAGS
endif


let g:tagbar_type_myhelp = {
	\ 'ctagstype' : 'myhelp',
	\ 'kinds' : [
		\ 's:section'
	\ ],
	\ 'sort' : 0
\ }

let g:tagbar_type_text = {
	\ 'ctagstype' : 'text',
	\ 'kinds' : [
		\ 's:section'
	\ ],
	\ 'sort' : 0
\ }


" ------------------------------------------------
" Vim_Matchup
" ------------------------------------------------
if exists("g:plugs") && has_key(plugs, 'vim-matchup')
    " don't show off-screen match in status line
    let g:matchup_matchparen_offscreen = {}
endif
