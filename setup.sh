#!/bin/bash
############################
# Inspired from https://github.com/michaeljsmalley/dotfiles
############################

########## Variables

dir=~/programming/dotfiles                    # dotfiles directory
olddir=~/.dotfiles.old             # old dotfiles backup directory
files="bash_profile zshrc gitconfig"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

install_zsh () {
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
      # Clone my oh-my-zsh repository from GitHub only if it isn't already present
      if [[ ! -d $dir/oh-my-zsh/ ]]; then
          git clone http://github.com/robbyrussell/oh-my-zsh.git
      fi
      # Set the default shell to zsh if it isn't currently set to zsh
      if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
          chsh -s $(which zsh)
      fi
  else
      # If zsh isn't installed, get the platform of the current machine
      platform=$(uname);
      # If the platform is Linux, try an apt-get to install zsh and then recurse
      if [[ $platform == 'Linux' ]]; then
          if [[ -f /etc/redhat-release ]]; then
              sudo yum install zsh
              install_zsh
          fi
          if [[ -f /etc/debian_version ]]; then
              sudo apt-get install zsh
              install_zsh
          fi
      # If the platform is OS X, tell the user to install zsh :)
      elif [[ $platform == 'Darwin' ]]; then
          echo "Please install zsh, then re-run this script!"
          exit
      fi
  fi
}

install_vim_gotta_go_fast () {
  if [[ ! -d ~/gotta-go-fast-vim/ ]]; then
      cd ~
      git clone git@github.com:posva/gotta-go-fast-vim.git
      cd gotta-go-fast-vim
      ./install.sh
      cd $dir
  fi
}

install_zsh
install_vim_gotta_go_fast
