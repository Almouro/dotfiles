# GIT
declare-git-aliases () {
	while read -r line; do alias g$line='git '$line; done
}

git config --get-regexp ^alias\. | cut -d' ' -f1 | sed -r 's/alias\.//' | declare-git-aliases
ls /usr/lib/git-core/ | sed -r 's/git-//' | declare-git-aliases

# RANDOM FORTUNE COWSAY
random-fortune (){
	fortune | random-cowsay
}

random-cowsay (){
	cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)
}

# ANSIBLE
export ANSIBLE_NOCOWS=1

# COMPOSER
PATH=$PATH:$HOME/.composer/vendor/bin

# VAGRANT
export VAGRANT_HOME=~/programming/VirtualBoxes
alias vagrant-halt-all="vagrant global-status | awk '/running/{print $1}' | xargs -r -d '\n' -n 1 -- vagrant halt"
alias vus="vagrant up && vagrant ssh"
alias vhalt="vagrant halt"
alias vup="vagrant up"
alias vssh="vagrant ssh"
alias vsshx="vagrant ssh -- -X"

# SYMFONY
alias ac="app/console"
alias punit="phpunit -c app"
alias csf="./bin/php-cs-fixer fix --diff"

# CAPISTRANO
alias csd="cap staging deploy"
alias cpd="cap preproduction deploy"

# VPN
alias dvpn="sudo vpnc-disconnect"
alias vpns="if [ `ps aux |grep vpnc|grep -v grep|awk '{print $2}'` ]; then echo 'Connected'; else echo 'Not connected'; fi"

# THE FUCK
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias f='fuck'

# Other Utils
alias profile-edit='atom ~/.bash_profile'
alias profile-reload='. ~/.bash_profile'
alias path-pretty="tr ':' '\n' <<< \"$PATH\""
alias ssh-key-copy="xclip -sel clip < ~/.ssh/id_rsa.pub"
alias folder-size="sudo du -H --max-depth=1 . | sort -n -r"
alias ethernet="sudo ethtool -s eth0 speed 100 duplex full autoneg off && sudo dhclient"
