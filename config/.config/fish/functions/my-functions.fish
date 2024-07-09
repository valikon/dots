# -- System utils -- #

function login_github; ssh-add $HOME/.ssh/github_rsa_id; end
function login_rsa; ssh-add $HOME/.ssh/id_rsa; end

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

## -- Network -- ##
function localip -d "Get my local ip"
    ip -json route get 8.8.8.8 | jq -r '.[].prefsrc'
end

function myip -d "Check my external IP"
    echo (curl -s checkip.dyndns.org | awk '{print $6}' | cut -d '<' -f1)
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

#function reload_emacs_config
#    rm ~/.emacs.d/init.el
#    if test -e ~/.emacs.d/init.elc
#        rm ~/.emacs.d/init.elc
#    end
#    cp ~/dot-files/emacs/init.el ~/.emacs.d/
#end
