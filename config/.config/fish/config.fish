source ~/.config/fish/aliases.fish
source ~/.config/fish/nmap_aliases.fish
source ~/.config/fish/functions/my-functions.fish

set VIRTUAL_ENV_DISABLE_PROMPT "1"

## Environment setup
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Restore wal color scheme on spawn
#cat .cache/wal/sequences

# hooks for direnv utility for autoloading env variables in a directory context
if command -q direnv
    direnv hook fish | source
end

## Starship prompt
if status --is-interactive
   source ("/usr/bin/starship" init fish --print-full-init | psub)
end

zoxide init fish | source

fnm env --use-on-cd | source

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/valle/.ghcup/bin # ghcup-env