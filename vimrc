"No original vi's bugs and limitations.
set nocompatible

"backspace removes autoindent, join lines, insert start
set backspace=indent,eol,start

set nobackup		" do not keep a backup file ending with "~" character
set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display partial commands in the last line
set incsearch		" do incremental searching
set nowrap
set noshowmode      " because it is now provided by the status line


" Pathogen plugin manager
call pathogen#infect() 

" Airline Status line
" set t_Co=256
set laststatus=2
" set encoding=utf-8


" dont prompt to save chanes 
set hidden

" leader
let mapleader=","


" line numbers hybrid mode
if exists('+relativenumber')
    set relativenumber
endif
set number

" mouse should not select line numbers
" TODO: disables copying y to clipbord, there fore not using it
" set mouse=a

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END

    " --------- File type specifi settings ---------- "

    "au FileType c set makeprg=gcc\ %
    "au FileType cpp set makeprg=g++\ %

    " 2 tab spaces for xml
    autocmd FileType xml setl sw=2 sts=2 et

    " git commit
    autocmd Filetype gitcommit setlocal spell textwidth=72

else
    set autoindent		" always set autoindenting on
endif " has("autocmd")



set cindent         "Context base indenting for C-code
set cino=l1         "Allign with case label
set tabstop=4       "4-space tabs
set shiftwidth=4    "autoindent setting
set expandtab       "convert tab to spaces
set softtabstop=4   "backspace key treat four spaces like a tab


set guioptions-=T   "No GUI toolbar
set guioptions+=b   "show bottom scroll bar

set sessionoptions+=resize,winpos

set nohls           "Don't highlight search matches
set ignorecase      "ignore case only if the search pattern is all in lower-case
set smartcase

set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>



"ignore white spaces in diff mode
set diffopt+=iwhite


"Don't put comment on newline when current line is commented
set comments-=://

"Two lines of context visible around the cursor at all times.
set scrolloff=2

"automatically save files when changing buffers
set autowrite 

"show some autocomplete options in status line
set wildmenu
" ignore filetypes for auto complete
set wildignore+=*.lib,*.o,*.obj

"share clipboard with X11 clipboard
set clipboard+=unnamedplus
" share clipboard with windows clipboard
set clipboard+=unnamed


" Turn on color syntax highlighting
syn on

" turn on timing out on mappings and key codes
set timeout

" wait 4 seconds for all keys in a mapping to be pressed.
set timeoutlen=4000

" timeout on key codes after 10th of a second.
set ttimeoutlen=100

" instead of showing cscope results in the current window
" put them in the quickfix window then use :cn :cp to jump
" :cl to see all and :cc [nr] to jump to [nr]
set csqf=s-,c-,d-,i-,t-,e-

" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" 0 = check cscope for definition of a symbol before checking ctags: 
" 1 = check ctags for definition of a symbol before checking cscope: 
set csto=0

" XML Folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" --------- commands --------- 

" diff between current buffer and the file it was opened from
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


" -------- Settings -------- "

" highlight spelling errors with a bright orange curly line
 if has("gui_running")
     highlight SpellBad term=underline gui=undercurl guisp=Orange
     set guifont=Monospace\ 11
 endif
"  

" --------- color shceme --------"
"colorscheme base16-default
set background=dark
let g:solarized_termcolor=16
colorscheme solarized

" auto write file on leaving
autocmd BufLeave,FocusLost * silent! wall

au BufRead,BufNewFile *.mlog        set filetype=mandlog
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" -------- Key Mappings -------- "

" map + to insert blank line before current line
" map - to insert blank line after current line
" dont allow remapping of these keys
nnoremap + maO<esc>`a
nnoremap - mao<esc>`a
map <F4> :cnext<CR>
nnoremap <F5> :GundoToggle<CR>
map <F1> :ls<CR>

" window navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

"BDelete
nnoremap <Leader>d :Bdelete<CR>
" find counterpart file .h --> .cpp etc
nnoremap <Leader>h :CounterpointNext<CR>
nmap <Leader>f :cs f f 
nmap <Leader>g :cs f g 
nmap <Leader>n ]c <F6>
" jk as ESC key
inoremap jk <ESC>

"Explore buffers
:noremap <Tab> :bnext<CR>
:noremap <S-Tab> :bprevious<CR>

" Search for the ... arguments separated with whitespace (if no '!'),
" " or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
    if a:0 > 0
        let sep = (a:bang) ? '\_W\+' : '\_s\+'
        let @/ = join(a:000, sep)
    endif
endfunction


"F9 toggles the hlsearch setting. The 'inv' prefix on a boolean setting toggles
"it. The trailing '/<BS>' clears the clutter left in the : command area
map <F9> :set invhls<CR>:let @/="<C-r><C-w>"<CR>/<BS>


"hit 'CTRL-\', followed by one of the cscope search types above (s,g,c,t,e,f,i,d)
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  


"Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>



" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


" ----------------------------
"            SCRATCH          
" ----------------------------
let g:scratch_autohide = 0



" ----------------------------
"            GUNDO
" ----------------------------
"let g:gundo_width = 60
"let g:gundo_preview_height = 40
"let g:gundo_right = 1


" ----------------------------
"          LIGHTLINE
" ----------------------------

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left' : [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'funcname' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ] 
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'funcname' : 'MyFuncName',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '«' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '| '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


function! MyFuncName()
  if exists("*tagbar#currenttag")
    let _ = tagbar#currenttag('%s',' ')
    return ._
  endif
  return ''
endfunction

" ----------------------------
"          NERDTREE
" ----------------------------
" close vim if window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" ----------------------------
"          VIM-NOTES
" ----------------------------
let g:notes_directories = ['~/Documents/vim-notes']

" ----------------------------
"          TAGBAR
" ----------------------------
try
    nnoremap <leader>t :TagbarOpenAutoClose<cr>
        let g:tagbar_ctags_bin='/home/aawais/local/ctags' 
catch
endtry


" ----------------------------
"         VIMWIKI 
" ----------------------------
" let wiki = {}
" let wiki.path = '~/vimwiki/'
" let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
" let g:vimwiki_list = [wiki]


" ------------------------------------------------
"                      NETRW
" Remote/Local directory browsing and file editing
" ------------------------------------------------
" turn off the banner
let g:netrw_banner=0


