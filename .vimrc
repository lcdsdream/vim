" luchaodong
" 20160606
" monkey year horse month
" 20170528
set fileformats=unix,dos,mac

"默认使用 plugin/linuxsty.vim
"移除下列配置才生效
set smartindent
set autoindent
set cindent
set tabstop=4 "Tab的宽度
set softtabstop=4 "统一缩进为
set shiftwidth=4
set expandtab "使用空格代替制表符
"set noexpandtabp "不使用空格代替制表符
"set expandtab后，设置smarttab，在删除tab（4个空格）只需一下Backspace
set smarttab

set langmenu=zh_CN.UTF-8 "语言设置
"set lbr "自动断行
"set fo+=mB

"close the noise bell
set vb t_vb=

function! Set_index_4()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set smarttab
endf

function! Set_index_kernel()
    set tabstop=8
    set softtabstop=8
    set shiftwidth=8
    set noexpandtab
endf

function! Set_index_2()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endf

" 显示括号配对情况
set sm
" 设置选择文本时候，包括光标所在
set selection=inclusive
" 右键单击弹出快捷菜单
set mousemodel=popup


filetype plugin on
filetype plugin indent on     " required!

"au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
"au FileType css setlocal dict+=~/.vim/dict/css.dict
"au FileType c setlocal dict+=~/.vim/dict/c.dict
"au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
"au FileType scale setlocal dict+=~/.vim/dict/scale.dict
"au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
"au FileType html setlocal dict+=~/.vim/dict/javascript.dict
"au FileType html setlocal dict+=~/.vim/dict/css.dict

" 插件管理
execute pathogen#infect()

set rtp+=$GOROOT/misc/vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all=1
syntax on

if has('python') " if dynamic py|py3, this line already activates python2.
  let s:python_version = 2
elseif has('python3')
  let s:python_version = 3
else
  let s:python_version = 0
endif


" 显示标尺
" 插入模式关闭
set cul
autocmd InsertLeave * se cul
autocmd InsertEnter * se nocul
"set cuc
"autocmd InsertLeave * se cuc
"autocmd InsertEnter * se nocuc

set shortmess=atI               " 启动的时候不显示那个援助乌干达儿童的提示
set go=                         " 不要图形按钮

set t_Co=256
if has('gui_running')
    "http://ethanschoonover.com/solarized
    color solarized
    set background=dark
else
    "color torte
    "color zenburn
    "color solarized
    color hybrid
    "set background=light
    set background=dark
endif
"set guifont=Courier_New:h10:cANSI   " 设置字体
"set guifont=WenQuanYi\ Zen\ Hei\ Mono\ 12.5

set ruler                       " 显示标尺
set showcmd                     " 输入的命令显示出来，看的清楚些
set scrolloff=3                 " 光标移动到buffer的顶部和底部时保持3行距离
set laststatus=2                " 启动显示状态行(1),总是显示状态行(2)
set foldenable                  " 允许折叠
"set foldmethod=manual          " 手动折叠

"显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

" 显示行号
set number
"set relativenumber

" 历史记录数
set history=1000
"搜索逐字符高亮
set hlsearch
set incsearch

" 总是显示状态行
set cmdheight=2

" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目

" 侦测文件类型
filetype on
" 为特定文件类型载入相关缩进文件
filetype indent on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""" keyboardmap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 全选
map <C-A> ggVG$"+y
" copy after select
vmap <C-c> $"+y
" 去空行
nnoremap <F2> :g/^\s*$/d<CR>
"去除行尾空
nnoremap <Leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" 列出当前目录文件
map <silent><F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
map <F4> :call Do_CsTag()<CR>
map <C-F4> :call Link()<CR>
map <F6> :call Set_index_4()<CR>
map <C-F6> :call Set_index_kernel()<CR>
map <S-F6> :call Set_index_2()<CR>
map <F7> ::ALEToggle<CR>
noremap <buffer> <C-F7> :call flake8#Flake8()<CR>
nmap <F9> :TagbarToggle<CR>
"nmap <silent><F9> <ESC>:Tlist<RETURN>
"
" 代码格式化
map <F12> gg=G

function! Link()
    if filereadable("tags")
        set tags=tags;,tags
    endif
    if filereadable("cscope.out")
        execute "cs add cscope.out"
    endif
endf

function! Do_CsTag()
    silent! execute "!ctags -R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+px --fields=+aiKSz --extra=+q *"
    silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.cxx' -o -name '*.hxx' -o -name '*.py' > cscope.files"
    silent!execute "!cscope -bq -i cscope.files"
    execute "cs kill -1"
    execute "cs add cscope.out"
endf

"将tab替换为4空格
nmap tt :%s/\t/    /g<CR>

imap <C-a> <Esc>^
imap <C-e> <Esc>$

" tab 切换
map <C-n> :tabnew<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

imap <C-j> <ESC>

"文件函数搜索设置
let g:Lf_ShortcutF = '<c-p>'       " Ctrl + p 打开文件搜索
"\p 打开函数列表
noremap <Leader>p :LeaderfFunction<cr>

:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"

"mrkdown to HTML
nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
nmap fi :!firefox %.html & <CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" othersetting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
endif

"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" show hiden file??
let NERDTreeShowHidden=1
" ignore File
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.git']
"let NERDTreeShowBookmarks=1


" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

"共享剪贴板
"set clipboard+=unnamed
"自动保存
set autowrite

set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏

" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set nobackup
set noswapfile

"搜索忽略大小写
set ignorecase

" 自动设置目录为当前文件所在目录
"set autochdir

set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu

" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2

" 允许backspace和光标键跨越行边界 (到行尾自动跳到下一行)
"set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=v
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

"set completeopt=longest,menu
"set completeopt=menu,menuone


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=tags;,tags


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope的设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
".vim/plugin/cscope_maps.vim
" show result in quickfix
" set cscopequickfix=s-,c-,d-,i-,t-,e-

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"默认打开Taglist
"let Tlist_Sort_Type = "name"    " 按照名称排序
"let Tlist_Auto_Open=0
"let Tlist_File_Fold_Auto_Close = 1
"let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
"let Tlist_Compart_Format = 1    " 压缩方式
"let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的
"let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"python补全
let g:pydiction_location = '~/.vim/after/complete-dict'
let g:pydiction_menu_height = 20
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

set iskeyword+=.
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

autocmd FileType python set omnifunc=pythoncomplete#Complete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件管理
"
set nocompatible               " be iMproved

call plug#begin('~/.vim/plugged')
" original repos on github
Plug 'ascenator/L9'
" 集成git， 命令行中 ：Gdiff 看看
Plug 'tpope/vim-fugitive'
" 缩进对齐线
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '┊'
" 快速搜索
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
"剪贴 外间<->vim
Plug 'vim-scripts/CaptureClipboard'
"导入预定义import
Plug 'mgedmin/python-imports.vim', {'for': ['py','python']}
"global mark
Plug 'vim-scripts/last_edit_marker.vim'
"颜色标记
Plug 'vim-scripts/synmark.vim'
"code注释
Plug 'orientlu/nerdcommenter'
" 远程协作
"Plug 'FredKSchott/CoVim'

Plug 'vim-scripts/ShowTrailingWhitespace'
"状态栏
"Plug 'Lokaltog/vim-powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='hybridline'

"python 跳转
Plug 'davidhalter/jedi-vim', {'for': ['py','python']}
"let g:jedi#auto_initialization = 0
"let g:jedi#auto_vim_configuration = 0
"let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = "1"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<S-Space>"
"let g:jedi#rename_command = "<leader>r"

" go  支持
" 配置好go ptah
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_def_mode = 'godef' "搜索补全
Plug 'majutsushi/tagbar', {'do' : 'go get -u github.com/jstemmer/gotags'}
":h tagbar-issues to get help
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'f:functions',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'p:package',
        \ 'i:imports',
        \ 'e:embedded',
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" 配置文件 toml 支持
Plug 'cespare/vim-toml'
" vim8 和之前版本
if version < 800
"语法检查 syntastic
    Plug 'vim-syntastic/syntastic'
    let g:fencview_autodetect=0
    let g:syntastic_python_checkers=['pylint']
    let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0


else  " vim8  支持异步
" ------------------------------------------------------ vim8 异步支持 begin
"语法检查 ale
    Plug 'w0rp/ale'
" 对应语言需要安装相应的检查工具
" https://github.com/w0rp/ale
"    let g:ale_linters_explicit = 1 "除g:ale_linters指定，其他不可用
"    let g:ale_linters = {
"\   'cpp': ['cppcheck','clang','gcc'],
"\   'c': ['cppcheck','clang', 'gcc'],
"\   'python': ['pylint'],
"\   'bash': ['shellcheck'],
"\   'go': ['golint'],
"\}
"
    let g:ale_sign_column_always = 1
    let g:ale_completion_delay = 500
    let g:ale_echo_delay = 20
    let g:ale_lint_delay = 500
    let g:ale_echo_msg_format = '[%linter%] %code: %%s'
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 0
    let g:airline#extensions#ale#enabled = 1
    let g:ale_java_javac_options = '-encoding UTF-8  -J-Duser.language=en' "java在中文系统提示中文乱码问题
    "let g:ale_set_quickfix = 1
    "let g:ale_open_list = 1"打开quitfix对话框

    let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
    let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
    let g:ale_c_cppcheck_options = ''
    let g:ale_cpp_cppcheck_options = ''

    let g:ale_sign_error = ">>"
    let g:ale_sign_warning = "--"

    "打开文件时不进行检查
    let g:ale_lint_on_enter = 0


"自动载入ctags gtags
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'

    let $GTAGSLABEL = 'native-pygments'
    let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
    "let $GTAGSCONF = '/usr/local/Cellar/global/6.6.3/share/gtags/gtags.conf'

    " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
    let g:gutentags_project_root = ['.root', 'BLADE_ROOT', '.git', 'go.mod']

    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'

    " 同时开启 ctags 和 gtags 支持：
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif
    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif

    " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " 配置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 如果使用 universal ctags 需要增加下面一行
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

    " 禁用 gutentags 自动加载 gtags 数据库的行为
    " 避免多个项目数据库相互干扰
    " 使用plus插件解决问题
    let g:gutentags_auto_add_gtags_cscope = 0

    "预览 quickfix 窗口 ctrl-w z 关闭
    Plug 'skywind3000/vim-preview'
    "P 预览 大p关闭
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
    noremap <S-k> :PreviewScroll -1<cr> " 往上滚动预览窗口
    noremap <S-j> :PreviewScroll +1<cr> "  往下滚动预览窗口

    "gtags 有问题 debug
    "打开一下语句，运行:GutentagsToggleTrace
    ":messages
    let g:gutentags_define_advanced_commands = 1

    " rust 支持
    Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave = 1
    "------------------------------------------------------ vim8 异步支持 end
endif


"python 自动缩进
Plug 'vim-scripts/indentpython.vim', {'for': ['py','python']}
"换行格式化
"Plug 'sillybun/autoformatpythonstatement', {'do':'./install.sh'}
"PEP8代码风格检查
"需要安装flake8
Plug 'nvie/vim-flake8', {'for': ['py','python']}

"对于有版本控制的文件，标注文件修改
Plug 'mhinz/vim-signify'

"c/cpp 语法标注
Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

"
" auto complete can use YouCompleteMe or tabnine-vim
"
"Plug 'zxqfl/tabnine-vim'
Plug 'Valloric/YouCompleteMe', {'do':'./install.py --clang-completer --go-completer --java-completer'}
set completeopt=menu,menuone "关闭自动弹出的函数说明窗口
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-y>'
noremap <c-y> <NOP>
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
"let g:ycm_global_ycm_extra_conf= '~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf= '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0 "导入工程自己的conf时提示确认

"自动补全[({})]
Plug 'jiangmiao/auto-pairs'

Plug 'Shougo/echodoc.vim'
let g:echodoc_enable_at_startup = 1


call plug#end()

"载入文件类型插件
filetype plugin on
filetype plugin indent on     " required!

" markdown配置
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" newfiletitle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
func SetTitle()
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "# by orientlu")
        call append(line(".")+1, "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "# by orientlu")
        call append(line(".")+2, "")
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby") call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "# by orientlu")
        call append(line(".")+2, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), " > File Name: ".expand("%:t"))
        call append(line(".")+1, " > Author: orientlu")
        call append(line(".")+2, " > Mail: lcdsdream@126.com")
        call append(line(".")+3, " > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif

    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:t:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:t:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:t:r"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G

"file plugin linux style will format c/cpp
"au BufNewFile,BufRead *.py exec ":call Set_index_4()" "default tab
au BufNewFile,BufRead *.js,*.html,*.css,*.yml exec ":call Set_index_2()"

augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end
