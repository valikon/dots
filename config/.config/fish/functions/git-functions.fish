#-----------#
#--- Git ---#
#-----------#

alias lg=lazygit

function ghc -d "Create a Github repo from local git project"
  gh repo create --private --source=. --remote=origin && 
  git push -u --all &&
  gh browse
end

function g -w git -d "Git"                                                     ; git	                  $argv; end
function ga -w "git add" -d "Git - add"                                        ; git add                $argv; end
function gaa -d "Git - add all"                                                ; git add --all               ; end
function gap -d "Git - add interactive"                                        ; git add -p                  ; end
function gb -w "git branch" -d "Git - branch"                                  ; git branch             $argv; end
function gba -d "Git - show all branches"                                      ; git branch -av              ; end
function gbd -w "git branch -D" -d "Git - delete branch"                       ; git branch -D          $argv; end
function gc -w "git commit" -d "Git - commit"                                  ; git commit             $argv; end
function gcl -w "git clone" -d "Git - clone"                                   ; git clone              $argv; end
function gclean -d "Git - clean up merged branches"                            ; git-clean-branches          ; end
function gcb -w "git checkout -b" -d "Git - checkout branch "                  ; git checkout -b        $argv; end
function gco -w "git checkout" -d "Git - checkout"                             ; git checkout           $argv; end
function gcm -w "git commit -m" -d "Git - commit with message"                 ; g commit -m            $argv; end
function gcmain -d "Git - checkout main"                                       ; git checkout main           ; end
function gcp -w "git cherry-pick" -d "Git - cherrypick"                        ; git cherry-pick        $argv; end
function gd -w "batdiff" -d "Git - diff"                                       ; git diff               $argv; end
function gds -w "git diff --staged" -d "Git - diff staged"                     ; git diff --staged      $argv; end
function gl -w "git pull" -d "Git - pull"                                      ; git pull --rebase      $argv; end
function gls -w "git ls-files" -d "Git - list files"                           ; git ls-files           $argv; end
function glg -d "Git - grep from listed files"                                 ; git ls-files | rg      $argv; end
function gm -w "git merge" -d "Git - merge"                                    ; git merge              $argv; end
function gp -w "git push" -d "Git - push"                                      ; git push               $argv; end
function gprune -d "Prune remote-tracking branches no longer on remote"        ; g fetch --prune        $argv; end
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
function grebranch -d "Git - delete branch and create a new one"               ; git branch -D          $argv; gcb $argv; end
function gw -w "git worktree" -d "Git - worktree"                              ; git worktree           $argv; end 
function gwa -w "git worktree add" -d "Git - worktree add"                     ; git worktree add $argv; end
function gwl -w "git worktree list" -d "Git - worktree list"                   ; git worktree list                      ; end
function gwr -w "git worktree remove" -d "Git - worktree remove"               ; git worktree remove               $argv; end
function gwip -d "Git - add & commit WIP"                           ; gaa; gls --deleted -z | xargs -0 g rm; gcm "wip" ; end
function gunwip -d "Git - reset from the last WIP commit"           ; g log -n 1 | grep -q -c wip; and grst HEAD~1; end
function glog; g log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative; end
