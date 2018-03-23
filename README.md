Simple Buffer
=============

[Simple Buffer](https://github.com/codcodog/simplebuffer.vim) is a plugin for switching and deleting buffers easily.

#### Installation
Using [vim-plug](https://github.com/junegunn/vim-plug)
```
Plug 'codcodog/simplebuffer.vim'
```

Using [Vundle](https://github.com/VundleVim/Vundle.vim)
```
Plugin 'codcodog/simplebuffer.vim'
```

#### Commands
`:SimpleBuffer` - open the `buffer` manager.

`:SimpleBufferClose` - close the `buffer` manager.

`:SimpleBufferToggle` - toggle to open/close the `buffer` manager.

#### Keybindings
| Key            | Description                                              |
| :----:         | :----:                                                   |
| `j`, `k`       | select `buffer`                                          |
| ``<C-v>``      | open the selected `buffer` vertically                    |
| ``<C-x>``      | open the selected `buffer` horizontally                  |
| `d`            | delete the selected `buffer`, which means to `bdelete`   |
| `D`            | wipeout the selected `buffer`, which means to `bwipeout` |
| `<Enter>`      | open the selected `buffer` on current window             |
| `q`, ``<ESC>`` | close the `buffer` manager                               |

#### License
Vim License
