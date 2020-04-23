# ItsOnlyCole's Dotfiles
The following directory contains my dotfiles for multiple machines. In the past, I used to git bare repositories, but some of my machines ran slightly different configs which mean running different git repos for both.

I've instead opted to now use one git repo for managing all my dotfiles, but instead of using a bare repository, I'll use [Stow](https://www.gnu.org/software/stow/) to manage dotfiles. With it I'll be able to use stow DIR to symlink dotfiles. This will allow me to have a directory for polybarDesktop and polybarLaptop for example.
