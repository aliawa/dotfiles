Common
----------------------------------------------------------------------
mkdir ~/Tools

oh-my-tmux
----------------------------------------------------------------------
cd ~/Tools
git clone https://github.com/gpakosz/.tmux.git oh-my-tmux
ln -s ~/dotfiles/tmux_ohmytmux.conf.local .tmux.conf.local


Requirements for bashrc
----------------------------------------------------------------------
1. bash_sensible -> git clone https://github.com/mrzool/bash-sensible.git
2. RUPA/z -> git clone https://github.com/rupa/z
3. FZF -> git clone --depth 1 https://github.com/junegunn/fzf.git
4. dircolors-solarized -> git clone git@github.com:seebi/dircolors-solarized.git

5. fd 
   fd is used by fzf
   wget https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-musl_8.7.0_i686.deb
   dpkg-deb -x fd-musl_8.7.0_i686.deb fd-musl
   
   TODO: manpage for fd does not work 
   cp fd-musl/usr/share/man/man1/fd.1.gz /home/aawais/bin/share/man/man1 

   Bash completion for fd
   mkdir -p ~/.local/share/bash-completion/completions
   fd-musl/usr/share/bash-completion/completions/fd ~/.local/share/bash-completion/completions


Requirements for bash_dev
----------------------------------------------------------------------
$HOME/pan_tools/common.h


VM setup
----------------------------------------------------------------------
ln -s ~/dotfiles/bash_profile .bash_profile
ln -s ~/dotfiles/bashrc .bashrc
ln -s ~/dotfiles/tmux_vm.conf .tmux.conf


.vimrc
----------------------------------------------------------------------
1. gtags in $PATH
   Ideally installed in ~/Tools
2. fzf installed at ~/Tools/fzf
   run ~/Tools/fzf/install
3. Itemr2:
   Profiles > Text > Use built-in Powerline glyphs
4. Universal-Ctags required for Tagbar, Note: Exuberant Ctags is the ancestor of Universal Ctags
   brew install universal-ctags
   apt install universal-ctags


