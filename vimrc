" General "{{{
set nocompatible " VI 兼容选项关闭
set history=700 " 历史记录里面储存多少行
set autoread " 文件被改动时自动载入
set timeoutlen=250 " 按下ESC后需要等待的时间
set autowrite " 自动保存
set clipboard+=unnamed " 共享剪贴板
set pastetoggle=<F11> " F11在PASTE模式之间切换
" Modeline
set modeline
set modelines=5
" Backup
" set nowritebackup
" set nobackup " 从不备份
" set directory=/tmp//
" Buffers
set hidden  " 缓冲区不用写入就可以隐藏
" Match and search
set hlsearch " 高亮搜索
set ignorecase " 查找时忽略大小写
set smartcase " 查找大写时不忽略
set incsearch
set path+=../
set path+=../../
" "}}}

" Formatting "{{{
"set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode
set fo-=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode
set fo-=r " Do not automatically insert a comment leader after an enter
set fo-=t " Do not auto-wrap text using textwidth (does not apply to comments)

set wrap
set wildmode=longest,list

set backspace=indent,eol,start
set whichwrap=h,l " 可以在多行移动

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " 将TAB转换为空格
set smarttab " Smarter tab levels

set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case


syntax on " 允许语法高亮
" "}}}

" Visual "{{{
set number
set showmatch " 显示匹配的括号
set matchtime=5 " 括号闪烁时间
set novisualbell " 禁止闪烁
set noerrorbells " No noise
set laststatus=2 " Always showstatus line
set vb t_vb= " disable any beeps or flashes on error
set ruler
set showcmd
set shortmess=atI " Shortens messages

set nolist " Display unprintable charcters f12 - switches
set listchars=tab:·\ ,eol:¶,trail:·,extends:»,precedes:« " Unprintable chars mapping

set foldenable " Turn on folding
set foldmethod=marker
" set foldlevel=100 " Don't autofold anything
set foldopen=block,hor,mark,percent,quickfix,tag

set mouse-=a " Disable mouse
set mousehide " Hide mouse after chars typed

set splitbelow
set splitright
set t_Co=256
colorscheme jellybeans
" }}}

" Command and Auto commands "{{{
" Sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

" Auto commands
au FileType html,python,vim,javascript setl shiftwidth=2
au FileType html,python,vim,javascript setl tabstop=2
au FileType java,php setl shiftwidth=4
au FileType java,php setl tabstop=4

" au BufRead,BufNewFile {COMMIT_EDITMSG}    set ft=gitcommit
" au BufRead,BufNewFile *.js set ft=javascript.jquery
au BufRead,BufNewFile *.tpl set ft=html.jquery
" 修改后自动载入
autocmd! bufwritepost vimrc source ~/.vimrc
" }}}

" Key mappings " {{{
" Tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>
" Duplication 
vnoremap <silent> <LocalLeader>= yP
nnoremap <silent> <LocalLeader>= YP

" Fast Saving
nnoremap <Leader>z :w!<CR>

" Splitline
nnoremap <silent> <C-J> gEa<CR><ESC>ew 

nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap * #

" 执行命令后的输出到文件中
nnoremap <C-I> <ESC>:read ! 

" 在分号前加一个右括号
map <C-A> $i)

map <silent> <F12> :set invlist<CR>
map <F5> :call Run()<CR>

func! Run()
  exec "w"
  if &filetype == 'php'
    exec "!php %"
  elseif &filetype == 'sh'
    exec "!sh %"
  endif
endfunc

" }}}

" Plugins "{{{
filetype off " 安装时选项
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
runtime ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
set laststatus=2
" ColorScheme
" Bundle 'nanotech/jellybeans.vim'
Bundle 'gmarik/vundle'
" yank history
Bundle 'vim-scripts/YankRing.vim'
" tags
Bundle 'vim-scripts/taglist.vim'
let Tlist_Use_Right_Window=1
let Tlist_File_Auto_Close=1
let Tlist_Exit_OnlyWindow=1
map <silent><F3> :TlistToggle<CR>
" Programming
Bundle 'jQuery'
Bundle 'jsbeautify'
Bundle 'php.vim'
Bundle 'phpfolding.vim'
" Git
" Bundle 'git.zip'
Bundle 'tpope/vim-fugitive'
" NEOComplcache{{{
Bundle 'Shougo/neocomplcache.vim'
let g:acp_enableAtStartup=0
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length=3
let g:neocomplcache_lock_buffer_name_pattern='\*ku\*'
let g:neocomplcache_dictionary_filetype_lists={
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
  \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}
" Fuzzyfinder {{{
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/FuzzyFinder'
let g:fuf_modesDisable = []
" }}}
Bundle 'kien/ctrlp.vim'

" NERD-Tree {{{
Bundle 'vim-scripts/The-NERD-tree'
let g:NERDChristmasTree=1 
let g:NERDTreeQuitOnOpen=1 
let g:NERDTreeMinimalUI=1 
let g:NERDShowBookMarks=1 
map <silent><F2> :NERDTreeToggle<CR>
" }}}
" Bundle 'The-NERD-Commenter'
Bundle 'vim-scripts/tComment'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>
" Utility
Bundle 'repeat.vim'
Bundle 'vim-scripts/surround.vim'

Bundle 'mattn/emmet-vim'
"powerline{{{
Bundle 'Lokaltog/powerline'
set guifont=PowerlineSymbols\ for\ Powerline
let g:Powerline_symbols = 'fancy'
"}}}}

Bundle 'Mark'
" %对齐更多的标签
Bundle 'vim-scripts/matchit.zip'
Bundle 'tpope/vim-pathogen'
"Bundle 'a.vim'

filetype plugin indent on " 自动对齐， 允许插件
"}}}
