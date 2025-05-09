################################
###  ENV VARS
################################

## Path
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH (brew --prefix rustup)/bin $PATH
set -gx PATH $HOME/.cargo/bin/ $PATH
set -gx PATH $HOME/.npm-global/bin/ $PATH
set -gx PATH $HOME/.ghcup/bin/ $PATH
set -gx PATH $HOME/go/bin $PATH
#set -gx PATH $HOME/.local/share/coursier/bin $PATH
set -gx PATH $HOME/scripts $PATH
set -gx PATH ./bin $PATH
set -gx PATH /opt/homebrew/opt/python@3.11/libexec/bin $PATH
set -gx GOPATH $HOME/go
set -gx GOROOT (brew --prefix go)/libexec

## System stuff
set -gx PROJECT_PATHS $HOME/projects # pj variable
set -gx EDITOR nvim
set -gx KUBE_EDITOR nvim
set -gx VIMCONFIG $HOME/.config/nvim
set -gx VIMDATA $HOME/.local/share/vim
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
#set -gx BROWSER qutebrowser

source ~/.config/fish/functions/my-functions.fish
source ~/.config/fish/nmap_aliases.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/key_bindings.fish
source ~/.current_assignment.fish

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

zoxide init fish | source

fnm env --use-on-cd | source

#pyenv init -

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/valle/.ghcup/bin # ghcup-env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/anaconda3/bin/conda
    eval /opt/homebrew/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<


