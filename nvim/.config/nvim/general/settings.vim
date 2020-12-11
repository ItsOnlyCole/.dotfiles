" General settings that aren't specific to any plugins

" sets leader key
let g:mapleader = "\<Space>"

colorscheme molokai     " Custom Colorscheme stored in nvim/colors/

syntax enable    		" Enables syntax highlighting
set nocompatible 		" Disables compatibility to old-time vi
set showmatch			" Show matching brackets
set ignorecase			" Case insensitive matching
set tabstop=4			" Sets tab to 4 spaces
set softtabstop=4		" See multiple spaces as tabstops
set expandtab			" Converts tabs to white space
set shiftwidth=4		" Width for autoindents
filetype plugin indent on	" Allows auto-indenting depending on filetype
set nowrap			" Display long lines as just one line
set encoding=utf-8 		" Sets encoding
set ruler 			" Show the cursor position at all times
set mouse=a			" Enable mouse support
set number			" Enable line numebrs
set clipboard=unnamedplus 	" Copy Paste between vim and rest of the computer


au! BufWritePost $MYVIMRC source % " auto-sources when writing to init.vim. Alternatively, you can run :source $MYVIMRC
