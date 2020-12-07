" ItsOnlyCole's init.vm
" 	To keep my nvim config orderly, I seperate configs by plugin or group.
" 	I then source them in here. All plugin configs (Excluding plug.vim [vim-plug])
" 	are stored in nvim/modules. General configs are stored in
" 	nvim/general.
" ##### Vim files loaded before plugins #####
source $HOME/.config/nvim/modules/vim-polyglot.vim

" ##### Plugins.Vim #####
" plugins.vim - vim-plug manager
source $HOME/.config/nvim/plugins.vim


" ##### Vim files loaded after plugins #####
