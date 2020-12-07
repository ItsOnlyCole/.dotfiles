" General settings that aren't specific to any plugins

" sets leader key
let g:mapleader = "\<Space>"

syntax enable    " Enables syntax highlighting
set nowrap			 " Display long lines as just one line
set encoding=utf-8 " Sets encoding
set ruler 			 " Show the cursor position at all times
set mouse=a			 " Enable mouse support
set number			 " Enable line numebrs
set clipboard=unnamedplus " Copy Paste between vim and rest of the computer

au! BufWritePost $MYVIMRC source % " auto-sources when writing to init.vim. Alternatively, you can run :source $MYVIMRC
