" set t_Co=256
" 语法高亮
set syntax=on

"""""""""""""""""""""""""""""""""""" 文件读写 """"""""""""""""""""""""""""""""""""
" 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java call SetTitle()|normal G
func SetTitle()
	" 如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\#########################################################################")
		call append(line("."), "\# File Name: ".expand("%"))
		call append(line(".")+1, "\# Author: uShangu")
		call append(line(".")+2, "\# mail: yujunlin5@163.com")
		call append(line(".")+3, "\# Created Time: ".strftime("%c"))
		call append(line(".")+4, "\#########################################################################")
		call append(line(".")+5, "\#!/bin/bash")
		call append(line(".")+6, "")
	else
		call setline(1, "/* ***********************************************************************")
		call append(line("."), "	> File Name: ".expand("%"))
		call append(line(".")+1, "	> Author: uShangu")
		call append(line(".")+2, "	> Mail: yujunlin5@163.com ")
		call append(line(".")+3, "	> Created Time: ".strftime("%c"))
		call append(line(".")+4, "	> Last Modified Time: ".strftime("%c"))
		call append(line(".")+5, "*************************************************************************/")
		call append(line(".")+6, "")
	endif
	if &filetype == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
    endif
	if &filetype == 'java'
		call append(line(".")+5,"")
	endif
	" 新建文件后，自动定位到文件末尾
	" autocmd BufNewFile * normal G
endfunc

" 更新最近修改时间
autocmd BufWritePre,FileWritePre *.html,*.[ch],*.cpp,*.java mark s|call LastMod()|'s
func LastMod()
	exec ":%g/> Last Modified Time:/s/> Last Modified Time:.*/> Last Modified Time: " . strftime("%c")
endfunc

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
 au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 去除每行后面多余的空格
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
" 去除多余文件后面多余的空行
autocmd BufRead,BufWrite * call TrimEndLines()
function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=


" 设置当文件被改动时自动载入
set autoread
" 共享剪贴板，需要安装gvim
set clipboard+=unnamed
let g:clipbrdDefaultReg = '+'
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"自动保存
set autowrite
" When i close a tab, remove the buffer
" 生成临时文件
set nohidden
set backup
" 注意要手动创建这些文件夹
set backupdir=~/.myvim/backup
set directory=~/.myvim/tmp
set noswapfile
" 历史记录数
set history=1000


"""""""""""""""""""""""""""""""""""" 一些vim配置 """"""""""""""""""""""""""""""""""""
" 设置魔术, for regular expressions
set magic
" quickfix模式
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
" 编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" 语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn
" 侦测文件类型 off for vundle
filetype on
" 载入文件类型插件
filetype plugin on
" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key
" 搜索忽略大小写
set ignorecase
set smartcase
" 行内替换
set gdefault
" 保存全局变量
set viminfo+=!
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=inclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" Automatically cd into the directory that the file is in
set autochdir


"""""""""""""""""""""""""""""""""""" 显示设置 """""""""""""""""""""""""""""""""""""""""""""
colorscheme ron
" 打开状态栏标尺
set ruler
" 突出显示当前行
set cursorline
" 显示当前列
set cursorcolumn
" cterm->teminal, ctermbg->background of terminal, ctermfg->foreground of
" terminal, that is, text color
hi CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=white
hi CursorColumn cterm=NONE ctermbg=darkgrey ctermfg=white
hi Folded ctermbg=Cyan ctermfg=white
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" 输入的命令显示出来，看的清楚些
set showcmd
" 左下角显示当前vim模式
set showmode
" 总是显示状态行
set laststatus=2
" 状态行显示的内容及配色
source ~/.statusLineColor.vim
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 搜索逐字符高亮
set hlsearch "highlighting searching
set incsearch "incremental searching
" 高亮显示匹配的括号
set showmatch
" Set off the other paren
highlight MatchParen ctermbg=4
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 折叠选项
set foldenable " 允许折叠
set foldmethod=manual " 手动折叠
set foldcolumn=0
set foldlevel=3
" 显示行号
set number
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l


""""""""""""""""""""""""""""""""""""" 补全与缩进 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 输入一个括号时自动补全另外的括号
:inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {<CR>}<ESC>O
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
" 打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menuone,preview

" html自动补全
autocmd Filetype html call SetHtmlMap()
function SetHtmlMap()
    exec ":inoremap > <ESC>:call InsertHtmlTag()<CR>a<CR><Esc>O"
endfunction

function! InsertHtmlTag()
    let pat = '\c<\w\+\s*\(\s\+\w\+\s*=\s*[''#$;,()."a-z0-9]\+\)*\s*>'
    normal! a>
    let save_cursor = getpos('.')
    let result = matchstr(getline(save_cursor[1]), pat)
    "if (search(pat, 'b', save_cursor[1]) && searchpair('<','','>','bn',0,  getline('.')) > 0)
    if (search(pat, 'b', save_cursor[1]))
        normal! lyiwf>
        normal! a</
        normal! p
        normal! a>
    endif
    :call cursor(save_cursor[1], save_cursor[2], save_cursor[3])
endfunction

"""""""""""""""""""""""""" 插件补全 """""""""""""""""""""""""""""""
" Omni plugin
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif
setlocal completefunc=javacomplete#CompleteParamsInfo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 为C程序提供自动缩进
set smartindent
" 用空格代替制表符
" 为特定文件类型载入相关缩进文件
filetype indent on
set expandtab
" 在行和段开始处使用制表符
set smarttab
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2


"""""""""""""""""""""""""""""""""""""""""  映射 """""""""""""""""""""""""""""""""""""""""
" You can map as follows for better display:
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Next Tab
nnoremap <silent> <C-h> :tabnext<CR>
" Previous Tab
nnoremap <silent> <C-l> :tabprevious<CR>
" New Tab
nnoremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-t> <Esc>:tabnew<CR>
" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" 映射全选+复制 ctrl+a
noremap <C-A> ggVGY
noremap! <C-A> <Esc>ggVGY
" 选中状态下 Ctrl+c 复制
vnoremap <C-c> "+y
map Y y$
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" 重定义vim中的按键
" Swap ; and : for convenience
nnoremap ; :
nnoremap : ;
" Go to home and end using capitalized directions
noremap H ^
noremap L $
" 用jj替换Esc
inoremap jj <Esc>
" 用kj
inoremap kj <Esc>A
" Searching mapping: Thess will make it so that going to the next one in a
" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 功能键
" C，C++ 按F5编译运行
noremap <F5> :call CompileRunGcc()<CR>
inoremap <F5> <Esc>:call CompileRunGcc()<CR>
func CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'py'
		exec "!python %"
		exec "!python %<"
	endif
endfunc
