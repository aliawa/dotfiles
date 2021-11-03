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
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'altercation/vim-colors-solarized'
    Plug 'lifepillar/vim-cheat40'
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py', 'for': ['python'] }
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
set guioptions-=T               " No GUI toolbar
set guioptions+=b               " show bottom scroll bar
set timeout                     " turn on timing out on mappings and key codes
set timeoutlen=4000             " wait 4 seconds for all keys in a mapping to be pressed.
set ttimeoutlen=100             " timeout on key codes after 10th of a second.

" color scheme
set background=dark
colorscheme solarized
autocmd VimResized * wincmd =  " auto splits equilzation

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
augroup autoRead           
    autocmd!
    autocmd CursorHold * silent! checktime
augroup END                     " auto reload if no cursor movement

                                          
                                               
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
set clipboard+=unnamedplus      " share clipboard with X11 clipboard
set clipboard+=unnamed          " share clipboard with windows clipboard


" ------------------------------------------------
" Mouse support
" ------------------------------------------------
" set mouse=n
" set mouse=a                   " Use mouse in all modes 
                                "   Good - mouse selection does not select line numbers
                                "   Bad - copy to clipboard does not work
" set ttymouse=xterm2            


" ------------------------------------------------
" Key Mappings
" ------------------------------------------------
let mapleader=","

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
nnoremap <Leader>i :cs f f %:t:r.c<CR>|                             " cscope Go to .c file  
nnoremap <Leader>f :cs f f|                                         " cscope find file
nnoremap <Leader>g :cs f g|                                         " cscope find symbol
nnoremap <Leader>n :set nonumber<CR> :set norelativenumber<CR>|     " disable all numbering

map <F3> :set paste!<CR>:startinsert<CR>|                           " Normal mode -> Paset+Insert mode
set pastetoggle=<F3>                                                " F3 toggles in and out of paste mode

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




" ------------------------------------------------
" Custom commands
" ------------------------------------------------

" diff between current buffer and the file it was opened from
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


if has("autocmd")
    augroup vimrcEx
        au!
        " Textwidth for text files
        autocmd FileType text setlocal textwidth=78

        " Jump to last known cursor position
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END

    " Commenting blocks of code.
    let b:comment_leader = '#' " Default value
    autocmd FileType c,cpp,java,scala let b:comment_leader = '//'
    autocmd FileType sh,ruby,python   let b:comment_leader = '# '
    autocmd FileType vim              let b:comment_leader = '" '

    noremap <silent> <Leader>cc :<C-U>
      \let old_reg=getreg('/')<Bar>let old_regtype=getregtype('/')<CR>
      \:<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
      \:call setreg('/', old_reg, old_regtype)<CR>

    noremap <silent> <Leader>cu 
      \let old_reg=getreg('/')<Bar>let old_regtype=getregtype('/')<CR>
      \:<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
      \:call setreg('/', old_reg, old_regtype)<CR>

endif


" ------------------------------------------------
" Cscope
" ------------------------------------------------
if has ("cscope")
    " 0 = check cscope for definition of a symbol before checking ctags: 
    " 1 = check ctags for definition of a symbol before checking cscope: 
    set csto=0
   
	" search cscope database as well as the tag file
	set cst

    " instead of showing cscope results in the current window
    " put them in the quickfix window then use :cn :cp to jump
    " :cl to see all and :cc [nr] to jump to [nr]
    set csqf=s-,c-,d-,i-,t-,e-

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb

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
" User defined
" ------------------------------------------------
function Appinfofix()
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
    split
    noswapfile enew                 "noswapfile {command}, run command without creating a swapfile
    setlocal buftype=nowrite
    setlocal bufhidden=hide
    file scratch                    "set name of current file
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
" Ctrlp.vim
" ------------------------------------------------
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'


