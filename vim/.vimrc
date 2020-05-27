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
" Plugin 'ycm-core/YouCompleteMe' " 代码自动补全插件，安装起来较麻烦
Plugin 'neoclide/coc.nvim'
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
set clipboard=unnamed
" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

autocmd VimEnter *.go NERDTree
let g:NERDTreeWinSize=25
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store$', '\.git$', '\.swp$'] " ignore files in nerd tree


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

language en_US
set langmenu=en   "set menu's language of gvim. no spaces beside '='

" let g:ycm_server_python_interpreter='/usr/bin/python'
" let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ackprg='ag --nogroup --nocolor --column'
let g:go_def_mode = 'gopls'
let g:go_info_mode='gopls'
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_metalinter_command='golangci-lint'
let g:go_fmt_command = "goimports"
" let g:go_metalinter_enabled = ['vet', 'errcheck --blank --lint', 'golint']
" let g:go_metalinter_autosave_enabled = ['vet', 'errcheck', 'bodyclose']
" let g:go_metalinter_autosave = 1

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
