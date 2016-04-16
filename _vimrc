""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
"winpos 5 5         				" 设定窗口位置  
"set lines=33 columns=155   		" 设定窗口大小  
set number							" 显示行号
"set go=							" 不要图形按钮  
"color asmanian2     				" 设置背景主题  
set guifont=Courier_New:h10:cANSI   " 设置字体  
syntax on           				" 语法高亮  
autocmd InsertLeave * se nocul  	" 用浅色高亮当前行  
autocmd InsertEnter * se cul    	" 用浅色高亮当前行  
set ruler           				" 显示状态栏标尺
set showcmd         				" 输入的命令显示出来，看的清楚些  
set cmdheight=1     				" 命令行（在状态行下）的高度，设置为1   
"set novisualbell    				" 不要闪烁
set nowrap  						" 不换行   
set foldenable      				" 允许折叠  
set foldmethod=manual   			" 手动折叠  
"set t_Co=256						" 256色
set background=dark 				" 背景颜色 
set nocompatible  					" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
"状态行显示的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   
" 总是显示状态行
set laststatus=2					"显示状态在行(2) 				

" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

" 设置配色方案
"colorscheme murphy
"字体 
"if (has("gui_running")) 
"   set guifont=Bitstream\ Vera\ Sans\ Mono\ 10 
"endif 
 

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: huyy") 
        call append(line(".")+2, "\# mail: huyy966@163.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: huyy") 
        call append(line(".")+2, "    > Mail: huyy966@163.com ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
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
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set mapleader
let mapleader = ","
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 
"新建标签  
map <M-F2> :tabnew<CR>  
"列出当前目录文件  
map <F3> :tabnew .<CR>  
"打开树状文件目录  
map <C-F3> \be  
nmap <F2> :nohlsearch<CR>
"map <F3> :copen<CR>:grep -R 
map <F7> :w<CR><CR>:copen<CR>:make<CR><CR>
imap <F7> <Esc>:w<CR><CR>:copen<CR>:make<CR><CR>
map <F9> :TlistToggle<CR>

"imap <C-P> <C-X><C-P>
"imap <C-F> <C-X><C-F>
"imap <C-I> <C-X><C-I>
"imap <C-D> <C-X><C-D>
"imap <C-L> <C-X><C-L>
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc> "p命令可以使用剪切板上的内容来替还选中的内容

"""""""""""""""""""""""""""""""
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>

""""""""""""""""""""""""""""""
" netrw setting
"""""""""""""""""""""""""""""""
let g:netrw_winsize = 20
"nmap <silent> <leader>fe :Sexplore!<cr>
"map <silent> <F6> : Vexplore<CR>	"开fileexploer，S代表当前分隔一个横向的窗口，V代表纵向

"""""""""""""""""""""""""""""""
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "! make"
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
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!gcc % -g -o %<"
	exec "!gdb ./%<"
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置当文件被改动时自动载入
set autoread
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"允许插件  
filetype plugin on
"共享剪贴板  
set clipboard+=unnamed 
"make 运行
:set makeprg=g++\ -Wall\ \ %
"自动保存
set autowrite
"set cursorline              " 为操作的一行添加下划线
set magic                   " 设置魔术
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
set foldcolumn=0
set foldmethod=indent 
set foldlevel=3 
"set foldenable              " 开始折叠
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 去掉输入错误的提示声音
set noeb
"set noerrorbells
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
set cindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
set noexpandtab
" 在行和段开始处使用制表符
set smarttab
" 历史记录数
set history=1000
"set path=.,/usr/include,/$HOME/.vim,
"备份设置
set nobackup
"set backup
"禁止生成临时文件
set noswapfile
"set bufhidden=hide
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
"在输入搜索的字符串同时就开始搜索已经输入的部分
set incsearch
"行内替换
set gdefault
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=zh_CN.UTF-8
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 保存全局变量
set viminfo+=!
" % 括号匹配
" gd 跳转到局部变量定义
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
"slet g:netrw_winsize = 20et guioptions+=b " 下面的滚动条开启
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
"set sidescroll=1	"屏幕放不下时，按一次屏幕移动一个字符
set scrolloff=3	    				" 光标移动到buffer的顶部和底部时保持3行距离  	
"set whichwrap=b,s,<,>,[,]		"跨行移动
"set list	"制表符可见
"set listchars=tab:>.,trail:-
" 为C程序提供自动缩进
set smartindent
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
"自动补全
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on "自动识别文件类型，用文件类型plugin脚本，使用缩进定义文件，加了这句才可以用智能补全
"代码补全 
set completeopt=preview,menu,longest
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tag list (ctags) 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Sort_Type = "name"    " 按照名称排序  
let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
let Tlist_Use_Lift_Window = 1  " 在左侧显示窗口  
let Tlist_Compart_Format = 1    " 压缩方式  
let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
"autocmd FileType java set tags+=D:\tools\java\tags  
"autocmd FileType h,cpp,cc,c set tags+=D:\tools\cpp\tags  
"let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的 
let Tlist_Auto_Open=0 			"默认打开Taglist
let Tlist_Ctags_Cmd = '/usr/bin/ctags' 
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
au BufWritePost *c,*cpp,*h !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 25
set tags=./tags,/usr/include/tags,$HOME/.vim/gtk_tags/tags_glib_gobject,$HOME/.vim/gtk_tags/tags_gdk_xlib,$HOME/.vim/gtk_tags/tags_gtk,$HOME/.vim/gtk_tags/tags_gdk,$HOME/.vim/gtk_tags/tags_glib_gio,$HOME/.vim/gtk_tags/tags_glib_glib,$HOME/.vim/gtk_tags/tags_gdk_pixbuf,$HOME/.vim/gtk_tags/tags_cairo,$HOME/.vim/gtk_tags/tags_pango
"set autochdir 
" minibufexpl插件的一般设置
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1  
