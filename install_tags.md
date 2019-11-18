# gtags 安装使用（vim）

## install gtags in ubuntu

直接使用apt-get安装的版本比较低，建议使用官网源码编译
[gnu global](https://www.gnu.org/software/global/download.html)
自己测试使用版本是 6.6.3, 6.0 时发现 label 查找不到 native-pygments

### 编译依赖
```bash
sudo apt-get install -y autoconf bison flex gperf libtool-bin texinfo
```

### 编译安装
```bash
./configure --with-sqlite3   # gtags可以使用Sqlite3作为数据库, 在编译时需要加这个参数
make -j4
sudo make install
```
```bash
# 报错需要 std99 的，直接修改下源码，不要直接for中初始i即可
vim ./gtags-cscope/find.c 
```

### 扩展支持其他语言
```
sudo apt-get install -y python-pip
pip install pygments
```

### 直接生成
```bash
## 生成tags
gtags –v
## 生成html
htags -DfFnva -m "指定main函数的名称" -t '这里填入你想要的主页title'
## 增量更新
global -vu
```

## install new ctags
[ Universal CTags ](https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst)

```bash
sudo apt-get install  -y autoconf pkg-config
git clone https://github.com/universal-ctags/ctags.git
cd ./ctags/
sh ./autogen.sh
./configure
make
sudo make install
cd .. && rm ./ctags -rf
```


## 配置vim

在vimrc 中加入
````vimrc
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
```
第一个 GTAGSLABEL 告诉 gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
第二个参数设置的路径根据实际安装(find / -iname gtags.conf),默认是上面那个。
版本过低的gtags  conf 可能找不到对应 label，所以推荐使用 6.6.3

---

## 参考
* [GNU](https://www.gnu.org/software/global/globaldoc_toc.html)

