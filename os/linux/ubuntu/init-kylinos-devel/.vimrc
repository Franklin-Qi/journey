"==========================================
" Vim settings
" Hello，我是PowerVim的作者，工程师Franklin-Qi
"==========================================



" Command line settings
:cnoremap <C-A> <Home>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>
:cnoremap b <S-Left> "ctrl_v alt_b
:cnoremap f <S-Right>

" Common settings
set nobackup
set noswapfile
set noerrorbells
set wildmenu
set wildmode=longest:list,full
set ignorecase
set hlsearch
set incsearch
set number
set relativenumber
set ruler
set cursorline
set cc=80
set showcmd		" display incomplete commands

" Tab indent to 4
"highlight RedundantSpaces ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t\|\t/
set expandtab
set showmatch
set guioptions-=T
set tabstop=4 " set ts=4
set shiftwidth=4 " set sw=4
set softtabstop=4

" Help documentation chinese
set helplang=cn
set encoding=utf-8

" Auto & smart indent
set smartindent
set autoindent

" fold
set foldenable
set foldmethod=syntax
set foldlevelstart=99
set foldcolumn=0
setlocal foldlevel=1
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" color theme, looking ~/.vim/colors/
colorscheme Monokai_Gavin

" Ctags settings
""map <F3> <Esc>:TlistToggle<Cr>
""let Tlist_Use_Right_Window = 1
""let Tlist_Compart_Format = 1
""let Tlist_Auto_Open=1
""let Tlist_Show_One_File = 1
""let Tlist_Exit_OnlyWindow = 1
""let Tlist_Sort_Type = "name"
""set tags=tags;
set tags=tags;/ "告诉在每个目录下如果找不到tags就到上一层目录去找
""set tags=~/.vim/systags
" set autochdir

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Shortcut keybinding
:set pastetoggle=<F10>

" parentheses auto completion
:inoremap < <><Esc>i
:inoremap > <c-r>=ClosePair('>')<CR>
:inoremap ( ()<Esc>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap [ []<Esc>i
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap { {<CR>}<Esc>O
":inoremap } <c-r>=ClosePair('}')<CR>
:inoremap { {}<Esc>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

map ms :call Setparentheses()<CR>
func! Setparentheses()
    :inoremap < <><Esc>i
    :inoremap > <c-r>=ClosePair('>')<CR>
    :inoremap ( ()<Esc>i
    :inoremap ) <c-r>=ClosePair(')')<CR>
    :inoremap [ []<Esc>i
    :inoremap ] <c-r>=ClosePair(']')<CR>
    :inoremap { {<CR>}<Esc>O
    :inoremap } <c-r>=ClosePair('}')<CR>
    :inoremap " ""<Esc>i
    :inoremap ' ''<Esc>i
endfunc

map md :call Delparentheses()<CR>
func! Delparentheses()
    :inoremap < <
    :inoremap ( (
    :inoremap [ [
    :inoremap { {
    :inoremap " "
    :inoremap ' '
endfunc

" tablin
set tabline=%!MyTabLine()  " custom tab pages line
function MyTabLine()
    let s = '' " complete tabline goes here
    " loop through each tab page
    for t in range(tabpagenr('$'))
        " set highlight
        if t + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " set the tab page number (for mouse clicks)
        let s .= '%' . (t + 1) . 'T'
        let s .= ' '
        " set page number string
        let s .= t + 1 . ' '
        " get buffer names and statuses
        let n = ''      "temp string for buffer names while we loop and check buftype
        let m = 0       " &modified counter
        let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
        " loop through each buffer in a tab
        for b in tabpagebuflist(t + 1)
            " buffer types: quickfix gets a [Q], help gets [H]{base fname}
            " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
            if getbufvar( b, "&buftype" ) == 'help'
                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
            elseif getbufvar( b, "&buftype" ) == 'quickfix'
                let n .= '[Q]'
            else
                let n .= pathshorten(bufname(b))
            endif
            " check and ++ tab's &modified count
            if getbufvar( b, "&modified" )
                let m += 1
            endif
            " no final ' ' added...formatting looks better done later
            if bc > 1
                let n .= ' '
            endif
            let bc -= 1
        endfor
        " add modified label [n+] where n pages in tab are modified
        if m > 0
            let s .= '[' . m . '+]'
        endif
        " select the highlighting for the buffer names
        " my default highlighting only underlines the active tab
        " buffer names.
        if t + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " add buffer names
        if n == ''
            let s.= '[New]'
        else
            let s .= n
        endif
        " switch to no underlining and add final space to buffer list
        let s .= ' '
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLineFill#999Xclose'
    endif
    return s
endfunction

execute pathogen#infect()
syntax on
filetype plugin indent on

"" markdown 高亮, 将文件名md 指向markdown 后缀
au BufRead,BufNewFile *.md setl filetype=markdown
let g:vim_markdown_folding_disabled = 1  "不折叠显示，默认是折叠显示，看个人习惯
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_folding_level = 6     "可折叠的级数，对应md的标题级别
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_emphasis_multiline = 0
set conceallevel=2
let g:vim_markdown_frontmatter=1


set nocompatible              " 去除VI一致性,必须要添加
" filetype off                  " 必须要添加

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'

" 以下范例用来支持不同格式的插件安装.
" 请将安装插件的命令放在vundle#begin和vundle#end之间.
" Github上的插件
" 格式为 Plugin '用户名/插件仓库名'
"Plugin 'tpope/vim-fugitive'

Plugin 'vimcn/vimcdoc'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'sheerun/vim-polyglot'
Plugin 'Raimondi/delimitMate'
""Plugin 'honza/vim-snippets'
""Plugin 'ycm-core/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'rking/ag.vim'
Plugin 'ggreer/the_silver_searcher'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'mileszs/ack.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc' " 生成markdown目录
Plugin 'iamcco/markdown-preview.nvim' " markdown 浏览


" 来自 http://vim-scripts.org/vim/scripts.html 的插件
" Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
"Plugin 'L9'
" 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
"Plugin 'git://git.wincent.com/command-t.git'
" 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
"Plugin 'file:///home/gmarik/path/to/plugin'
" 插件在仓库的子目录中.
" 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
"Plugin 'ascenator/L9', {'name': 'newL9'}

" 你的所有插件需要在下面这行之前
call vundle#end()
filetype plugin indent on

" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall     - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后


""let &runtimepath = expand('<sfile>:p:h:h')
" 设置Firefox浏览器路径
""let g:markdown_preview_sync_firefox_path = "/usr/bin/firefox"




" 目录树 (NerdTree)
" https://blog.csdn.net/bc516125634/article/details/88858097
map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>

let g:NERDTreeWinPos='left'
let g:NERDTreeSize=30
let g:NERDTreeShowLineNumbers=1
" let g:NERDTreeHidden=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1

" 快速添加/删除注释（nerdcommenter）
let g:NERDSpaceDelims            = 1                                    " 在注释符号后加一个空格
let g:NERDCompactSexyComs        = 1                                    " 紧凑排布多行注释
let g:NERDDefaultAlign           = 'left'                               " 逐行注释左对齐 \cc
let g:NERDAltDelims_java         = 1                                    " JAVA 语言使用默认的注释符号
let g:NERDCustomDelimiters       = {'c': {'left': '/*', 'right': '*/'}} " C 语言注释符号
let g:NERDCommentEmptyLines      = 1                                    " 允许空行注释
let g:NERDTrimTrailingWhitespace = 1                                    " 取消注释时删除行尾空格
let g:NERDToggleCheckAllLines    = 1                                    " 检查选中的行操作是否成功
" leader 可以通过help leader查看
" [count]<leader>cc     注释当前行起始的 [count]行
" [count]<leader>cu     取消选定行的注释
" [count]<leader>cs     使用块格式布局注释掉选定的行。
" [count]<leader>c<space>   切换所选行的注释状态。如果注释了最上面的选定行，则取消注释所有选定行
" <leader>ca 切换　// 和 /* */
" <leader>cy 注释并复制

" 状态栏优化（vim-airline）
let g:airline#extensions#tabline#enabled        = 1 " 开启 tabline
let g:airline#extensions#tabline#buffer_nr_show = 1 " 显示 buffer 编号
let g:airline#extensions#ale#enabled            = 1 " enable ale integration
let g:airline#extensions#tabline#formatter = 'unique_tail' " 显示标签的样式为只显示文件名
let g:airline_theme="dark"      " 设置主题

" 状态栏显示图标设置
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" let g:airline_left_sep          = '⮀" '
" let g:airline_left_alt_sep      = '⮁" '
" let g:airline_right_sep         = '⮂" '
" let g:airline_right_alt_sep     = '⮃'
let g:airline#extensions#tabline#left_sep = ' '            " tabline中当前buffer两端的分隔字符
let g:airline_right_alt_sep     = '|'
let g:airline_symbols.crypt     = '?'
" let g:airline_symbols.linenr    = '⭡'
" let g:airline_symbols.branch    = '⭠'
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
let g:airline_theme='papercolor'

" 关闭当前 buffer
" noremap <C-x> :w<CR>:bd<CR>
""noremap <C-x> :bd<CR>
" <leader>1~9 切到 buffer1~9
map <leader>1 :b 1<CR>
map <leader>2 :b 2<CR>
map <leader>3 :b 3<CR>
map <leader>4 :b 4<CR>
map <leader>5 :b 5<CR>
map <leader>6 :b 6<CR>
map <leader>7 :b 7<CR>
map <leader>8 :b 8<CR>
map <leader>9 :b 9<CR>


" NERDTree，所以就需要配合安装一个共享插件 vim-nerdtree-tabs
" vim启动时，不自动打开NERDTree
let g:nerdtree_tabs_open_on_console_startup=0

" 修改的文件和增加的文件都给出相应的标注 (nerdtree-git-plugin )
    ""let g:NERDTreeIndicatorMapCustom = {
    let g:NERDTreeGitStatusIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }



" 模糊搜索文件ctrlp.vim
" https://wxnacy.com/2017/09/23/vim-plugin-ctrlp/
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
"<Leader>b显示缓冲区文件，并可通过序号进行跳转
nmap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }

let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
"默认不使用正则表达式，置1改为默认使用正则表达式，可以用<C-r>进行切换
let g:ctrlp_regexp = 0
"自定义搜索列表的提示符
let g:ctrlp_line_prefix = '♪ '
let g:ctrlp_show_hidden = 1


" ctrlp-funky 可以模糊搜索文件内容的方法名
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']


" ack.vim     quick than grep
" Ubuntu: sudo apt install the_silversearcher-ag or silversearcher-ag
" https://vimawesome.com
" https://www.cnblogs.com/welhzh/p/7210110.html
let g:ackprg = 'ag --nogroup --color-match --column'
" let g:ackprg = 'ag --vimgrep'
" If [!] is not given the first error is jumped to.
map <c-k> :Ack!<space>


" complete python
autocmd BufNewFile *.py exec ":call SetTitlePy()"
func SetTitlePy()
    if &filetype == "python"
     call setline(1,"#!/usr/bin/env python3")
     call setline(2,"# -* - coding: UTF-8 -* -")
    endif
endfunc

map <F5> :call RunPython() <CR>
func! RunPython()
    exec "W"
    if &filetype == "python"
        exec "!time python3 %"
    endif

    if &filetype == "sh"
        exec "!time bash %"
    endif
endfunc

" complete bash
autocmd BufNewFile *.sh exec ":call SetTitleSh()"
func SetTitleSh()
    if &filetype == "sh"
     call setline(1,"#!/usr/bin/env bash")
     call setline(2,"# -* - coding: UTF-8 -* -")
    endif
endfunc

" a.vim 可以实现源文件头文件快速切换
"
" 头/源文件切换命令
"":A 头文件／源文件切换
"":AS 分割窗后并切换头/源文件(切割为上下两个窗口)
"":AV 垂直切割窗口后切换头/源文件(切割为左右两个窗口)
"":AT 新建Vim标签式窗口后切换
"":AN 在多个匹配文件间循环切换

""将光标所在处单词作为文件名打开
"":IH 切换至光标所在文件
"":IHS 分割窗口后切换至光标所在文件(指将光标所在处单词作为文件名打开)
"":IHV 垂直分割窗口后切换
"":IHT 新建标签式窗口后切换
"":IHN 在多个匹配文件间循环切换
""快捷键操作
""<Leader>ih 切换至光标所在文件*
""<Leader>is切换至光标所在处(单词所指)文件的配对文件(如光标所在处为foo.h，则切换至foo.c/foo.cpp...)
""<Leader>ihn 在多个匹配文件间循环切换
""
""*<Leader>指Vim所定义的映射(map)前缀，在Vim配置文件中可过变量'mapleader'进行设置，缺省为'\'。

