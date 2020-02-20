# Orient‘s vimrc record
@(linux 编程)


[vim 配置地址](https://github.com/lcdsdream/vim.git)
下面介绍该配置下的 vim 使用


## 缩进问题
* vim 默认设置4个空格缩进
* 对应 C/C++ 文件，打开通过 "vim/plugin/linuxsty.vim" 这个文件插件进行设置为 linux 内核风格。
* 其他语言，指定设置
如下，设置了 js 等类型文件缩进方式，其他可以自定添加修改

```bash
au BufNewFile,BufRead *.js,*.html,*.css exec ":call Set_index_2()"
```

##  主题颜色
* 配色设置，效果如配置 git 页面所示图片：

```bash
if has('gui_running')
    "http://ethanschoonover.com/solarized
    color solarized
    set background=dark
else
    color torte
    set background=light
endif
```
* 终端下配色效果
终端下使用vim的时候，颜色与预期不符，因为终端默认不支持256色。

```bash
echo "export TERM=xterm-256color" >> ~/.bashrc
source ~/.bashrc
```

## 自定义快捷键

* 去空行 ``F2``
* 去除行尾空格 ``\w``
* 列出文件目录 ``F3``
* 建立、更新代码查找 tag，cscope ``F4``
* 设置默认缩进空格 4 个 ``F6``
* 设置内核缩进风格 ``Ctrl-F6``
* 设置缩进风格 2个空格 ``Shift-F6``
* 开关代码检查　``F7``
* 进行python PE8 检查 ``ctrl-F7``
* 打开关闭 Tlist ``F9``
* 代码格式化 ``F12``
* 当前文件模糊函数查找 ``ctrl-p``
* 目录下模糊文件查找 ``\p``
* 将tab替换为空格  ``tt``
* 退出插入模式并到句首  ``Ctrl-a``
* 退出插入模式并到句尾 ``Ctrl-e``
* 退出插入模式 ``Crrl-j``
* tab 切换 ``Shift-h / Sift-l``

### 复制
* Ctrl - A 全选复制
* Ctrl - C 复制 visual模式下  **选中内容**
	* 复制剪贴板后，不能关闭vim（后台也不可）
	* ctrl-v 黏贴到其他文本
	* ctrl-shift-v 黏贴到终端/vim 内部命令行

### 查找
    ctrl-p  查找文件
    \p      查找函数
    以上，查找目标后，ctrl-x 在新水平窗口打开； ctrl-] 在新垂直窗口打开; ctrl-T 新tab打开

### vim8 支持异步自动更新tags
安装gtags，更新ctags [文档](install_tags.md)
自动索引以根目录下的.git .svn ... 确认工程目录，没有这些文件，可以手动添加.root
查找快捷方式定义
* ``<leader>cg`` - 查看光标下符号的定义
* ``<leader>cs`` - 查看光标下符号的引用
* ``<leader>cc`` - 查看有哪些函数调用了该函数
* ``<leader>cf`` - 查找光标下的文件
* ``<leader>ci`` - 查找哪些文件 include 了本文件
查找到索引后跳到弹出的 quikfix 窗口，停留在想查看索引行上，按 ``小P``直接打开预览窗口，``大P``关闭预览，``\d`` 和 ``\u`` 向上向下滚动预览窗口。
ctrl-o 跳转回去


### 在vim 中直接打开终端
* ConqueTermSplit bash<CR>
* ConqueTermVSplit bash<CR>

### 编写markdown文件
编写markdown文件(`*.md`)的时候，在normal模式下按 `md` 即可在当前目录下生成相应的`html`文件
- 生成之后还是在normal模式按`fi`可以使用firefox打开相应的`html`文件预览
- 如果打开过程中屏幕出现一些混乱信息，可以按`Ctrl + l`来恢复

---

## 问题

* gvim 启动报错

```bash
Gtk-Message: Failed to load module "canberra-gtk-module"

sudo apt install libcanberra-gtk-module libcanberra-gtk3-module
```

* gtags gtags-cscope job failed

尝试删除 cache 下的tag，可能是建立tag时推出导致文件有问题；比较的项目，tag 运行时间会长一点；

```bash
配置文件新增
let g:gutentags_define_advanced_commands = 1
打开vim
:GutentagsToggleTrace
出发错误，比如保存文件
：messages
查看log 定位
```


* unknown function: pythoncomplete#Complete

```bash
  if has('python') " if dynamic py|py3, this line already activates python2.
    let s:python_version = 2
  elseif has('python3')
    let s:python_version = 3
  else
    let s:python_version = 0
  endif
```

* 状态栏显示问题
设置字体库
```bash
git clone git@github.com:powerline/fonts.git
cd fonts & sh ./install.sh
或者：
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv ./PowerlineSymbols.otf /usr/share/fonts/
mv ./10-powerline-symbols.conf /etc/fonts/conf.d/
sudo fc-cache -fv
```
