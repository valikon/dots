#!/usr/bin/env bash

echo
echo "INSTALLING ESSENTIAL PACMAN PACKAGES"
echo

PKGS=(

    # SYSTEM --------------------------------------------------------------

    'base-devel'             # Package group with compiling and linking essentials
    'docker'                 # Containers
    'docker-compose'         # composer for docker
    'arch-wiki-docs'         # arch wiki docs
    'sddm'                   # login manager of choice

    # TERMINAL UTILITIES --------------------------------------------------

    'alacritty'             # Terminal emulator
    'bandwhich'             # Terminal bandwidth utilization tool
    'bat'                   # Cat clone with syntax highlighting and git integration
    'bash-completion'       # Tab completion for Bash
    'bleachbit'             # File deletion utility
    'cronie'                # cron jobs
    'curl'                  # Remote content retrieval
    'ctop'                  # Top-like interface for container metrics
    'exa'                   # ls replacement
    'fd'                    # faster alternative to find
    'fish'                  # Friendly Interactive Shell
    'powershell'            # windows powershell in linux
    'nushell'               # columnar data shell
    'fzf'                   # fuzzy finder
    'skim'                  # fuzzy finder in rust
    'fzy'                   # fzf alternative
    'gtop'                  # System monitoring via terminal
    'gufw'                  # Firewall manager
    'htop'                  # Process viewer
    'neofetch'              # Shows system info when you launch terminal
    'ntp'                   # Network Time Protocol to set time via network.
    'numlockx'              # Turns on numlock in X11
    'openssh'               # SSH connectivity tools
    'ranger'                # vim-like file manager
    'lf'                    # ranger inspired file manager
    'rsync'                 # Remote file sync utility
    'ripgrep'               # better grep
    'the_silver_searcher'   # rg alternative
    'sd'                    # find and replace
    'speedtest-cli'         # Internet speed via terminal
    'stow'                  # config management
    'starship'              # cross-shell prompt
    #'tlp'                   # Advanced laptop power management
    'tmux'                  # term window multiplexer
    'unrar'                 # RAR compression program
    'unzip'                 # Zip compression program
    'wget'                  # Remote content retrieval
    'terminator'            # Terminal emulator
    'tldr'                  # community man pages
    'yay'                   # yoghurt
    'z'                     # most frequent directories
    'zenity'                # Display graphical dialog boxes via shell scripts
    'zip'                   # Zip compression program
    'zsh'                   # ZSH shell
    'zsh-completions'       # Tab completion for ZSH
    'lolcat'                # rainbows!!
    'pwgen'                 # passwd generator
    'unison'                # file sync tool
    'hwinfo'                # hardware detection
    'neovim'                # vim improved
    'git-delta'             # syntax highlighting for git and diff output
    'difftastic'            # Diff tool that compares files based on their syntax
    'zoxide'                # directory jump with z
    'eva'                   # simple calculator REPL, similar to bc
    'procs'                 # ps replacement

    # DISK UTILITIES ------------------------------------------------------

    'exfat-utils'           # Mount exFat drives
    'gparted'               # Disk utility
    'parted'                # Disk utility
    'dust'                  # Filespace usage
    'lfs'                   # Info on mounted filesystems

    # GENERAL UTILITIES ---------------------------------------------------

    'sxhkd'                 # simple X hotkey daemon
    'rofi'                  # application launcher
    #'catfish'               # Filesystem search
    'conky'                 # System information viewer
    'nemo'                  # Filesystem browser
    #'veracrypt'             # Disc encryption utility
    'variety'               # Wallpaper changer
    'flameshot'             # Screenshots
    'clipit'                # Lightweight GTK+ clipboard manager
    'arandr'                # gui for xrandr
    'qbittorrent'           # torrent client
    'qutebrowser'           # vim-like browser
    'brave-browser'         # chromium based browser
    'okular'                # pdf viewer
    'meld'                  # file diffs
    'python-pywal'          # generate and install color schemes
    'pdftk'                 # pdf tool
    'nomacs'                # image viewer
    'doublecmd-qt5'         # twin-panel file manager
    'fortune-mod'           # fortune application

    # PROGRAMMING LANGUAGE  -----------------------------------------------

    'go'                    # compiler tools for the Go programming language
    'rustup'                # rust tooling
    'clang'                 # C Lang compiler
#    'nodejs'               # Javascript runtime environment ## Install via fnm instead
    'python'                # Scripting language

    # DEVELOPMENT ---------------------------------------------------------

    'jq'                    # json processor
    #'hub'                   # github cli
    'helm'                  # kubernetes package manager
    'code'                  # Text editor
    'emacs'                 # So much more than just a text editor
    'helix'                 # vim inspired editor written in rust
    'kate'                  # Text editor
    'cmake'                 # Cross-platform open-source make system
    'electron'              # Cross-platform development using Javascript
    'git'                   # Version control system
    'lazygit'               # tui git tool
    'gcc'                   # C/C++ compiler
    'glibc'                 # C libraries
    'meld'                  # File/directory comparison
    'npm'                   # Node package manager
    'qtcreator'             # C++ cross platform IDE
    'qt5-examples'          # Project demos for Qt
    'yarn'                  # Dependency management (Hyper needs this)
    'tokei'                 # count lines of code (LOC)
    'ghcup'                 # haskell toolchain utility
    'python-pipenv'         # pipfile, pip & virtualenv
    'mkcert'                # make locally-trusted dev certs
    'ctags'                 # indexer for source files, used by plugins
    'prettier'              # code formatter for JS

    # NETWORK -------------------------------------------------------------

    'traceroute'            # track packet route over IP network
    'nmap'                  # network discovery and security auditing
    'dog'                   # Command-line DNS client like dig

    # WEB TOOLS -----------------------------------------------------------

    'filezilla'             # FTP Client

    # COMMUNICATIONS ------------------------------------------------------

    'discord'               # voice and text chat

    # MEDIA ---------------------------------------------------------------

    'obs-studio'            # Record your screen
    'vlc'                   # Video player
    'feh'                   # Fast and light image viewer
    'freeoffice'            # office suite

    # GRAPHICS AND DESIGN -------------------------------------------------

    'gcolor2'               # Colorpicker
    'gimp'                  # GNU Image Manipulation Program

    # VIRTUALIZATION ------------------------------------------------------

    'virtualbox'            # VMs
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
