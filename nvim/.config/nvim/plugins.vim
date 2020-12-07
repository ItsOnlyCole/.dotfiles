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
	


call plug#end()

" Autoinstalls missing plugins on startup
autocmd VimEnter *
	\ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\|   PlugInstall --sync | q
	\| endif
