Simple Buffer
=============

简单易用的 `buffer` 管理插件.

#### 安装
使用 [vim-plug](https://github.com/junegunn/vim-plug) 进行安装
```
Plug 'codcodog/simplebuffer.vim'
```

#### 命令
`SimpleBuffer`：打开 `buffer` 管理.

`SimpleBufferClose`：关闭 `buffer` 管理.

`SimpleBufferToggle`：如果 `buffer` 管理没打开则打开它，若已经打开则关闭它.

#### Mapping
| 映射 | 描述 |
|:----:|:----:|
|``<C-v>``|垂直打开选中 `buffer`|
|``<C-x>``|水平打开选中 `buffer`|
|`d`|删除选中 `buffer`，相当于 `bdelete`|
|`D`|移除选中 `buffer`，相当于 `bwipeout`|
|`<Enter>`|回车，直接在当前窗口打开选中 `buffer`|
|`q`, ``<ESC>``|关闭 `buffer` 管理|

#### License
MIT
