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
set -gx PATH $HOME/scripts $PATH
set -gx PATH ./bin $PATH
set -gx GOPATH $HOME/go
set -gx GOROOT (brew --prefix go)/libexec

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

## SSH
ssh-add ~/.ssh/github_id
ssh-add ~/.ssh/gitlab_id

## System stuff
set -gx EDITOR nvim
set -gx KUBE_EDITOR nvim
set -gx VIMCONFIG $HOME/.config/nvim
set -gx VIMDATA $HOME/.local/share/vim
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

source ~/.config/fish/functions/my-functions.fish
source ~/.config/fish/nmap_aliases.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/key_bindings.fish

set VIRTUAL_ENV_DISABLE_PROMPT "1"

# hooks for direnv utility for autoloading env variables in a directory context
if command -q direnv
    direnv hook fish | source
end

starship init fish | source

set -g fish_greeting

zoxide init fish | source

fnm env --use-on-cd | source
