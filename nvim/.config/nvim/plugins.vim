"  auto-install vim-plug if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir
	  \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	"autocmd VimEnter * PlugInstall
	"autocmd VimEnter * PlugInstall | source $MYVIMRC
endif



" ####Plugins used####
" Plugins installed to nvim/autoload/plugged/
" Settings/keybinds for each plugin is in nvim/modules/
call plug#begin('~/.config/nvim/autoload/plugged')
	
	" Better Syntax Support
	Plug 'sheerun/vim-polyglot'
	" Nerdtree File Explorer
	Plug 'scrooloose/nerdtree'
    " Nerdtree Icons
    Plug 'ryanoasis/vim-devicons'
	" Airline Status Bar
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " COC 'Intelisense'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Whichkey Popup Menu
    Plug 'liuchengxu/vim-which-key'

	" CoC Extensions
	"Plug 'neoclide/coc-discord-rpc'
	"Plug 'neoclide/coc-css'
	"Plug 'neoclide/coc-flutter'
	"Plug 'neoclide/coc-html'
	"Plug 'neoclide/coc-json'
	"Plug 'neoclide/coc-markdownlint'
	"Plug 'neoclide/coc-omnisharp'
	"Plug 'neoclide/coc-python'
	"Plug 'neoclide/coc-sh'
	"Plug 'neoclide/coc-spell-checker'
	"Plug 'neoclide/coc-tsserver'
	"Plug 'neoclide/coc-xml'

call plug#end()

" Autoinstalls missing plugins on startup
autocmd VimEnter *
	\ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\|   PlugInstall --sync | q
	\| endif
