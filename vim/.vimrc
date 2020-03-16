set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

set rtp+=~/.vim/bundle/Vundle.vim

filetype off " 必填

call vundle#begin()

Plugin 'mileszs/ack.vim' " vim内搜索插件
Plugin 'Raimondi/delimitMate' " 符号自动补全，被动触发，如自动补全[],()等。
Plugin 'scrooloose/nerdtree' " 目录管理插件，必装插件
Plugin 'VundleVim/Vundle.vim' " vim插件管理器，必装
Plugin 'fatih/vim-go' " Go工具管理，必装
Plugin 'majutsushi/tagbar' " tagbar能在侧边栏展示Go源码中的类/方法/变量等, 可以选中快速跳转到目标位置
Plugin 'bronson/vim-trailing-whitespace' " 高亮行末空格(标红), 也可以一键去除文件中所有行行尾空格
Plugin 'ycm-core/YouCompleteMe' " 代码自动补全插件，安装起来较麻烦
Plugin 'vim-airline/vim-airline' " 状态栏美化插件
Plugin 'kannokanno/previm' " markdown预览插件，十分好用
Plugin 'tyru/open-browser.vim' " 在vim内打开浏览器，配合previm就可以一边编辑，一边在浏览器上预览
Plugin 'jistr/vim-nerdtree-tabs' " nerdtree的增强插件
"Plugin 'vim-scripts/SuperTab'

call vundle#end()

filetype plugin on

let g:indent_guides_enable_on_vim_startup = 0

set nocompatible " 这个设置表示不兼容老版本vi，使用vim的扩展功能，必写
set ts=4 " 设置tab为4个空格
set smarttab " 根据文件中其他地方的缩进空格个数来确定一个 tab 是多少个空格
set smartindent " 智能对齐
set shiftwidth=4
set nu!
set autowrite " 设置自动保存内容
set ignorecase " 搜索忽略大小写
set hlsearch " 开启搜索结果的高亮显示
set incsearch " 边输入边搜索(实时搜索)
set cursorline " 高亮光标所在的行
set completeopt=menu
set expandtab
set backspace=2
set encoding=utf-8
" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

autocmd VimEnter *.go NERDTree
let g:NERDTreeWinSize=25

syntax on

colorscheme molokai

" Normal模式下的快捷键
map <F2> :GoDef<CR>
map <F3> :GoReferrers<CR>
map <F5> :GoRun<CR>
map <F8> :TagbarToggle<CR>
map <F10> :NERDTreeToggle<CR>
map <S-s> :GoImports<CR>
map <S-f> :GoFmt<CR>

" 从vim内复制到vim外
" 具体操作是进入VISUAL模式，选中按下;y，再ctrl+v
let mapleader=";"
vnoremap <leader>y :w !pbcopy<CR><CR>
vnoremap <leader>p :r !pbpaste<CR><CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>A :Ag<CR>

highlight Visual cterm=reverse ctermbg=NONE

let $LANG = 'en'  "set message language
set langmenu=en   "set menu's language of gvim. no spaces beside '='

let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ackprg='ag --nogroup --nocolor --column'
let g:go_def_mode = 'gopls'
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
