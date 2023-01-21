################################
###  Navigation/Editing
################################
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
alias ls='exa -la --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias lt2='ls-tree-level 2'
alias lt3='ls-tree-level 3'

alias D="cd ~/Downloads"
alias d="cd ~/dots"
alias p="cd ~/projects"
alias tmp="cd /tmp"

################################
###  System & config
################################
alias diff=difft
alias i=pac-install
alias py=python
alias e=nvim
alias weather=wttr
alias lg=lazygit

function psgrep                ; ps aux | rg $argv                                      ; end
function reload                ; source ~/.config/fish/config.fish                      ; end # reload config
function sconf                 ; bat ~/.config/fish/aliases.fish | rg $argv             ; end # search aliases.config
function emc -d "Emacs client" ; emacsclient -a "" -c $argv &                           ; end
function ls-tree-level -d "Exa --tree to $arg level ignoring .git/ and .gitignore files"
    exa -aT --icons --color=always --group-directories-first --ignore-glob=".git" --git-ignore --level $argv
end
function jpg_convert           ; magick $arg -quality 100% $arg.jpg                     ; end

function screen1 -d "Screen - Only the one screen"    ; bash ~/.screenlayout/my-layout.sh    ; end
function screen2 -d "Screen - Home screen"            ; bash ~/.screenlayout/my-layout2.sh   ; end
function screen3 -d "Screen - Office screen"          ; bash ~/.screenlayout/my-layout3.sh   ; end
function screen4 -d "Screen - Uppsala office screen"  ; bash ~/.screenlayout/my-layout4.sh   ; end

################################
###  GIT
################################
function g -w git -d "Git"                                                     ; git	                  $argv; end
function ga -w "git add" -d "Git - add"                                        ; git add                $argv; end
function gaa -d "Git - add all"                                                ; git add --all               ; end
function gap -d "Git - add interactive"                                        ; git add -p                  ; end
function gb -w "git branch" -d "Git - branch"                                  ; git branch             $argv; end
function gba -d "Git - show all branches"                                      ; git branch -av              ; end
function gbd -w "git branch -D" -d "Git - delete branch"                       ; git branch -D          $argv; end
function gc -w "git commit" -d "Git - commit"                                  ; git commit             $argv; end
function gcl -w "git clone" -d "Git - clone"                                   ; git clone              $argv; end
function gcb -w "git checkout -b" -d "Git - checkout branch "                  ; git checkout -b        $argv; end
function gco -w "git checkout" -d "Git - checkout"                             ; git checkout           $argv; end
function gcm -d "Git - checkout master"                                        ; git checkout master         ; end
function gcmsg -w "git commit -m" -d "Git - commit with message"               ; g commit -m            $argv; end
function gcp -w "git cherry-pick" -d "Git - cherrypick"                        ; git cherry-pick        $argv; end
function gd -w "git diff" -d "Git - diff"                                      ; git diff               $argv; end
function gds -w "git diff --staged" -d "Git - diff staged"                     ; git diff --staged      $argv; end
function gl -w "git pull" -d "Git - pull"                                      ; git pull               $argv; end
function gls -w "git ls-files" -d "Git - list files"                           ; git ls-files           $argv; end
function glg -d "Git - grep from listed files"                                 ; git ls-files | rg      $argv; end
function gm -w "git merge" -d "Git - merge"                                    ; git merge              $argv; end
function gp -w "git push" -d "Git - push"                                      ; git push               $argv; end
function grb -w "git rebase" -d "Git - rebase"                                 ; git rebase             $argv; end
function grbc -w "git rebase --continue" -d "Git - continue rebase"            ; git rebase --continue  $argv; end
function gr -w "git restore" -d "Git - restore"                                ; git restore            $argv; end
function grs -w "git restore --staged" -d "Git - Restore staged changes"       ; git restore --staged   $argv; end
function grst -w "git reset" -d "Git - Reset"                                  ; git reset              $argv; end
function grsoft -w "git reset --soft" -d "Git - Soft reset"                    ; git reset --soft       $argv; end
function grhard -w "git reset --hard" -d "Git - Hard reset"                    ; git reset --hard       $argv; end
function gt -w "git tag" -d "Git - tag"                                        ; git tag                $argv; end
function gs -w "git status -s" -d "Git - short status"                         ; git status -s          $argv; end
function gst -w "git status" -d "Git - full status"                            ; git status             $argv; end
function gsh -w "git show HEAD" -d "Git - show HEAD"                           ; git show HEAD          $argv; end
function gstash -w "git stash" -d "Git - stash"                                ; git stash              $argv; end
function gstd -w "git stash drop" -d "Git - drop stash"                        ; git stash drop         $argv; end
function gstp -w "git stash pop" -d "Git - pop stash"                          ; git stash pop          $argv; end
function gstl -w "git stash list" -d "Git - list stash"                        ; git stash list         $argv; end
function gsts -w "git stash show --text" -d "Git - show stash"                 ; git stash show --text  $argv; end
function grebranch -d "Git - delete branch and create a new one"    ; g branch -D $argv; gcb $argv; end
function gwip -d "Git - add & commit WIP"                           ; gaa; gls --deleted -z | xargs -0 g rm; gcmsg "wip" ; end
function gunwip -d "Git - reset from the last WIP commit"           ; g log -n 1 | grep -q -c wip; and grst HEAD~1; end
function glog; g log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative; end

################################
###  DOCKER
################################
alias dkc=docker-compose
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
function st -w stack                            ; stack                      $argv; end
function stp -w "stack build --fast --pedantic" ; st build --fast --pedantic $argv; end
function stb -w "stack build"                   ; st build                   $argv; end
function stf -w "stack build --fast"            ; st build --fast            $argv; end
function sti -w "stack install"                 ; st install                 $argv; end
function str -w "stack ghci"                    ; st ghci                    $argv; end
function std                                    ; st build                   $argv --dry-run; end
function stn                                    ; st ghci                    $argv --no-build; end
function ghcl                                   ; ghc-pkg list               $argv; end
function ghcu                                   ; ghc-pkg unregister         $argv; end

################################
###  OpenVPN
################################
alias thm-vpn-connect='sudo openvpn /etc/openvpn/valikon.ovpn &'

################################
###  OTHER
################################
alias cat='bat --style header --style rule --style snip --style changes --theme 1337'
alias ip="ip -color"
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
alias rmpkg='pacman -Rns'       ### Remove package with dependencies
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

function update -d "Upgade pacman and AUR packages"; sudo aura -Syu --noconfirm; and sudo aura -Au --noconfirm; end
