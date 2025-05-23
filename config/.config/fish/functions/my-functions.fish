# -- System utils -- #
function su; command su --shell=/usr/bin/fish $argv; end

## -- General utility --##
function cheat -a tool -d "Search cheatsheet"
    curl cheat.sh/$tool | cat
end

function server -d "Start an HTTP server from a directory"
  open http://localhost:8080/
  and python -m http.server 8080
end

function backup --argument filename
    cp $filename $filename.bak
end

function md -d "Make directory with path"
  mkdir -p "$argv"; cd "$argv"
end

function kp -d "Kill processes"
  set -l __kp__pid (ps -ef | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]'" | awk '{print $2}')
  set -l __kp__kc $argv[1]

  if test "x$__kp__pid" != "x"
    if test "x$argv[1]" != "x"
      echo $__kp__pid | xargs kill $argv[1]
    else
      echo $__kp__pid | xargs kill -9
    end
    kp
  end
end

function copy -d "Copy directories"
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	      set from (echo $argv[1] | string trim --right)
	      set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## -- Development -- ##
function git-delete-merged-branches -d "Git - delete merged branches"
    set primary (git branch --list 'master' 'main' | string match -r '^\*?\s*(master|main)$' | string replace -r '^\* ' '' | string trim | head -n1)

    if test -n "$primary"
      set merged_branches (git branch --merged=$primary | grep -v $primary | string trim)
      if test -n "$merged_branches"
        git branch --merged=$primary | grep -v $primary | xargs git branch -d
        echo "Deleted merged branches."
      else
        echo "No merged branches found to delete."
      end
    end
end

function git-delete-gone-branches -d "Git - delete [gone] branches"
    set gone_branches (git branch -v | string match -r '.*\[gone\].*' | string replace -r '^\s*(\S+).*$' '$1')

    if test -n "$gone_branches"
        echo "Found the following [gone] branches:"
        printf "%s\n" $gone_branches

        echo -e "\nDo you want to delete these branches? [y/N]"
        read -l confirm

        if test "$confirm" = "y" -o "$confirm" = "Y"
            for branch in $gone_branches
                echo "Deleting branch: $branch"
                # Use -d for safe delete (only merged branches)
                # Use -D for force delete (regardless of merge status)
                git branch -D $branch
            end
        else
            echo "Operation cancelled"
            return 1
        end
    else
        echo "No [gone] branches found"
        return 0
    end
end

function git-clean-branches -d "Git - clean up branches"
  git-delete-merged-branches
  git-delete-gone-branches
 
  git fetch --prune
  echo "Pruned remote branches"
end

## -- Network -- ##
function localip -d "Get my local ip"
    ip -json route get 8.8.8.8 | jq -r '.[].prefsrc'
end

function myip -d "Check my external IP"
    curl ifconfig.me
    # echo (curl -s checkip.dyndns.org | awk '{print $6}' | cut -d '<' -f1)
end

## -- Package management -- ##
function pac-install -d "Search and install package" --argument pkg
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
end

function aur-install -d "Search and install package from AUR" --argument pkg
    if test -z $pkg
        echo "Please enter the name of the package you are searching for."
    else
        aura -As $pkg | rg 'aur/*' | cut -d ' ' -f 1 | cut -c 5- | fzf --multi --preview 'aura -Ai {1}' | xargs -ro sudo aura -A
    end
end

## -- Random -- ##
function wttr -a city -d "Weather forecast"
    set query
    if test -z $city
        set -a query "stockholm"
    else
        set -a query $city
    end
    curl "wttr.in/"(string join '' $query "?M")
end

### -- PDF UTILS -- ##
function pdfmerge -d "Merge two or more pdf files in order to a new file"
    set arg_count (count $argv)
    if [ $arg_count -ge 3 ]
        pdftk $argv[1..(math $arg_count - 1)] cat output $argv    [$arg_count]
    else
        echo "You need to specify at least three arguments"
        echo "e.g. FILE_1 FILE_2 OUTPUT_FILE"
    end
end
