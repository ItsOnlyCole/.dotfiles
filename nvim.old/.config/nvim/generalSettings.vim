" set leader key
let g:mapleader = "\<Space>"

syntax enable			" Enables syntax highlighting
set hidden 			" Required to keep multiple buffers open
set nowrap			" Disables wordwrap
set encoding=utf-8		" Sets encoding to UTF-8
set pumheight=10		" Sets popup menu height
set fileencoding=utf-8		" Sets encoding for writing to files
set ruler			" Shows cursor position at all times
set cmdheight=2			" Sets command bar height for displaying messages
set iskeyword+=-		" Treats dash seperated words as word text object i.e. on-campus
set mouse=a			" Enables mouse support
set splitbelow			" Sets new horizontal window splits to be below
set splitright			" Sets new vertical window splits to be on the right
set t_Co=256			" Enables 256 color support
set conceallevel=0		" Disables syntax concealing
set tabstop=4			" Inserts 4 spaces for a tab
set shiftwidth=4		" Sets number of spaces for indentation
set smarttab			" Makes tabbing smarter for determining 2v4 spaces for tabs
set expandtab			" Convert tabs to spaces
set smartindent			" Enables smart indenting
set autoindent			" Enables autoindent
set laststatus=0		" Always display the status line
set number			" Enables line numbers
set cursorline			" Enable highlighting of the current line
set background=dark		" Set background color
set showtabline=4		" Always show tabs
set noshowmode			" Disables showing vim modes like --INSERT--
set nobackup			" Enabled for coc use
set nowritebackup		" Enabled for coc use
set updatetime=300		" Faster completion
set timeoutlen=500		" Canges default timeoutlength to 500ms (1000ms default)
set formatoptions-=cro		" Prevents comments from continuing to a new line
set clipboard=unnamedplus	" Enables copy/paset between vim and the regular clipboard
set autochdir			" Sets working directory to the directory you start nvim in

au! BufWritePost $MYVIMRC source %	" auto source when writing to init.vim alternatively you could run :source $MYVIMRC

cmap w!! w !sudo tee %
