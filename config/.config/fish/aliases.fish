################################
###  Navigation/Editing
################################
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
function cx -w "cd" -d "change directory"; cd $argv && ls; end

function l -w "eza"; eza --color=always --git --group-directories-first --icons $argv ; end
alias la="l -a"
alias ls='l -la'
alias lt='ltl 2' 
function ltl -d "Eza - list tree to $arg level ignoring .git/ and .gitignore files"
    l -aT --ignore-glob=".git" --git-ignore --level $argv
end

alias D="cd ~/Downloads"
alias d="cd ~/dots"
alias p="cd ~/projects"
alias tmp="cd /tmp"

################################
###  System & config
################################
alias mkdir='mkdir -p'
alias sudo='sudo -E ' # -E tells sudo to respect the environment it's being started in
alias i=pac-install
alias py=python
alias weather=wttr
alias top=bpytop

function e                     ; set -gx NVIM_APPNAME nvim; nvim $argv                  ; end
function psgrep                ; ps aux | rg $argv                                      ; end
function reload                ; source ~/.config/fish/config.fish                      ; end # reload config
function jpg_convert           ; magick $arg -quality 100% $arg.jpg                     ; end

################################
### Cloud
################################
alias assume="source (brew --prefix)/bin/assume.fish"
alias tf=terraform
alias tg=terragrunt
function tga -d "Terragrunt run-all" ; terragrunt run-all $argv    ; end

alias sp='steampipe'
alias pipe='powerpipe'

alias cantrill-prod="assume cantrill-prod"
alias cantrill-dev="assume cantrill-dev"

################################
### K8s
################################
alias kubectl=kubecolor
alias k=kubectl
alias keti='k exec -ti'
alias kg='k get'
alias kga='k get all'
alias kl='k logs'
alias kd='k describe'
alias kdel='k delete'
alias kt='k top'

# context
alias kcx='kubectx'
alias kccc='k config current-context'
alias kcgc='k config get-contexts'

# pods
alias kgp='kg pod'
alias kdp='kd pod'
alias kgpl='kgp -l' # get pods by label
alias kgpn='kgp -n' # get pods by namespace
alias kgpw='kgp --watch' # after listing, watch for changes
alias kgpwide='kgp -o wide' # plain-text with additional information

# deployment
alias kdd='kd deployment'
alias kgd='kg deployment'

# node
alias kdn='kd node'
alias kgn='k get nodes -L karpenter.sh/nodepool -L node.kubernetes.io/instance-type -L topology.kubernetes.io/zone'

# service
alias kgs='kg svc' # list services in ps output format
alias kds='kd svc'
alias kgsw='kgs --watch' 
alias kgswide='kgs -o wide'
alias kdsa='kd sa' # describe a service account in details

alias kns='kubens'

# minikube
alias mk='minikube'

################################
###  DOCKER
################################
alias dc=docker-compose
function drun -w "docker run -d"     ; docker run -d $argv  ; end
function dstr -w "docker start"      ; docker start $argv   ; end
function dstp -w "docker stop"       ; docker stop $argv    ; end
function dps -w "docker ps"          ; docker ps $argv      ; end
function dpsa -w "docker ps -a"      ; docker ps -a         ; end
function di -w "docker images"       ; docker images $argv  ; end
function drm -w "docker rm"          ; docker rm $argv      ; end
function drmi -w "docker rmi"        ; docker rmi $argv     ; end

################################
###  TMUX
################################
alias tmux="tmux -2"
function tls -d "Tmux - list sessions"      ; tmux ls                      ; end
function td  -d "Tmux - detach"             ; tmux detach $argv            ; end
function tks -d "Tmux - kill session"     ; for s in (tmux list-sessions | awk '{print $1}' | rg ':' -r '' | fzf-tmux); tmux kill-session -t $s; end; end

################################
###  RUST
################################
function c -w cargo -d "Cargo (Rust package manager)"               ; cargo                   $argv; end
function cdoc -w "cargo doc" -d "Cargo - doc"                       ; cargo doc               $argv; end
function cn -w "cargo new" -d "Cargo - new"                         ; cargo new               $argv; end
function cc -w "cargo check" -d "Cargo - check"                     ; cargo check             $argv; end
function cb -w "cargo build" -d "Cargo - build"                     ; cargo build             $argv; end
function cbr -w "cargo build --release" -d "Cargo - build release"  ; cargo build --release   $argv; end
function cr -w "cargo run" -d "Cargo - run"                         ; cargo run               $argv; end

################################
###  NPM/NODE
################################
function npms -d "NPM - start"              ; npm run-script start     $argv ; end
function npmb -d "NPM - build"              ; npm run-script build     $argv ; end
function npmt -d "NPM - test"               ; npm run-script test      $argv ; end

################################
###  HASKELL
################################
# function st -w stack                            ; stack                      $argv; end
# function stp -w "stack build --fast --pedantic" ; st build --fast --pedantic $argv; end
# function stb -w "stack build"                   ; st build                   $argv; end
# function stf -w "stack build --fast"            ; st build --fast            $argv; end
# function sti -w "stack install"                 ; st install                 $argv; end
# function str -w "stack ghci"                    ; st ghci                    $argv; end
# function std                                    ; st build                   $argv --dry-run; end
# function stn                                    ; st ghci                    $argv --no-build; end
# function ghcl                                   ; ghc-pkg list               $argv; end
# function ghcu                                   ; ghc-pkg unregister         $argv; end

################################
###  OpenVPN
################################
alias thm-vpn-connect='sudo openvpn /etc/openvpn/valikon.ovpn &'

################################
###  BAT with extras
################################
alias cat='bat --style header --style rule --style snip --style changes --theme 1337'
function rgb -w "batgrep" ; batgrep -i --color --hidden $argv; end

################################
###  OTHER
################################
# alias ip="ip -color"
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -Acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias jctl="journalctl -p 3 -xb" # Get the error messages from journalctl
#[ ! -x /usr/bin/aura ] && [ -x /usr/bin/paru ] && alias aura='paru'

################################
###  System Package Management
################################
alias pkg-rm='pacman -Rns'       ### Remove package with dependencies
alias pkg-info='aura -Qi'        ### Display information on PACKAGE
alias pkg-orphans='aura -Qdt'    ### List orphaned packages
alias pkg-ls='pacman -Ql'        ### List all files owned by PACKAGE
alias pkg-own='pacman -Qo'       ### Search for package that owns FILE
alias pkg-cleanup='sudo pacman -Rns (pacman -Qtdq)'  ### Clean up orphaned packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # Recent installed packages

alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# function update -d "Upgade pacman and AUR packages"; sudo aura -Syu --noconfirm; and sudo aura -Au --noconfirm; end
