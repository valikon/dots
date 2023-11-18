################################
###  ENV VARS
################################

## Path
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH $HOME/.cargo/bin/ $PATH
set -gx PATH $HOME/.npm-global/bin/ $PATH
set -gx PATH $HOME/.ghcup/bin/ $PATH
set -gx PATH $HOME/go/bin $PATH
#set -gx PATH $HOME/.local/share/coursier/bin $PATH
set -gx PATH $HOME/scripts $PATH
set -gx PATH ./bin $PATH
set -gx PATH /opt/homebrew/opt/python@3.11/libexec/bin $PATH
set -gx GOPATH $HOME/go

## System stuff
set -gx PROJECT_PATHS $HOME/projects # pj variable
set -gx EDITOR nvim
set -gx VIMCONFIG $HOME/.config/nvim
set -gx VIMDATA $HOME/.local/share/vim
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
#set -gx BROWSER qutebrowser

source ~/.config/fish/aliases.fish
source ~/.config/fish/nmap_aliases.fish
source ~/.config/fish/functions/my-functions.fish

set VIRTUAL_ENV_DISABLE_PROMPT "1"

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# hooks for direnv utility for autoloading env variables in a directory context
if command -q direnv
    direnv hook fish | source
end

starship init fish | source

set -g fish_greeting

#zoxide init fish | source

fnm env --use-on-cd | source

#pyenv init -

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/valle/.ghcup/bin # ghcup-env
