# TODO: create a wtb function to automatically create a branch if one doesn't exist
# TODO: autocomplete for the wta function

function gw -w "git worktree" -d "Git - worktree"                              ; git worktree           $argv; end 
function wtl -w "git worktree list" -d "Git - worktree list"                   ; git worktree list                      ; end
function wtr -w "git worktree remove" -d "Git - worktree remove"               ; git worktree remove               $argv; end

##
# Switch between git root and worktree
##
function wt -d "Switch between git root and worktree" 
  # Check if inside a worktree directory
  set current_path (pwd)
  set parent_path $current_path
  set found_parent 0

  while test "$parent_path" != "/"
    if test -d "$parent_path/.worktree" && test "$parent_path" != "$current_path"
      # Found a parent with .worktree, to the parent
      cd $parent_path
      set_color bryellow
      echo "Returned to worktree parent directory"
      set_color normal
      return
    end
    set parent_path (dirname $parent_path)
  end

  # Check if worktree exists
  if not test -d ".worktree"
    set_color brred
    echo "No worktree found ☹️"
    set_color normal
    return 1
  end

  # List all directories under .worktree
  set worktree_dirs (find .worktree -mindepth 1 -maxdepth 1 -type d | sort)

  # Count directories
  set dir_count (count $worktree_dirs)

  if test $dir_count -eq 1
    # Only one directory
    cd $worktree_dirs[1]
    set_color bryellow
    echo "Switched to worktree "(basename $worktree_dirs[1])
    set_color normal
  else
    # Multiple directories
    set selected_dir (find .worktree -mindepth 1 -maxdepth 1 -type d | sort | fzf --height 40% --reverse --prompt="Select worktree: ")

    if test -n "$selected_dir"
      cd $selected_dir
      set_color bryellow
      echo "Switched to "(basename $selected_dir)
      set_color normal
    else
      set_color brred
      echo "No directory selected ☹️"
      set_color normal
    end
  end
end

#
# Create a git worktree
#
function wta -d "Create a git worktree"
  if test (count $argv) -ne 2
    set_color brcyan
    echo "Usage: wta <directory_name> <branch_name>"
    echo "Example: wta feature-123 featre/123"
    set_color normal
    return 1
  end

  set dir_name $argv[1]
  set branch_name $argv[2]

  if not test -d ".worktree"
    set_color brblue
    echo "Creating .worktree directory"
    set_color normal
    mkdir -p .worktree
  end

  set_color brblue
  echo "Creating worktree for branch '$branch_name' in directory '.worktree/$dir_name'..."
  set_color normal
  git worktree add .worktree/$dir_name $branch_name

  if test $status -eq 0
    cd .worktree/$dir_name
    set_color bryellow
    echo "Switched to worktree $dir_name"
    set_color normal
  else
    set_color brred
    echo "Failed to create worktree."
    set_color normal
  end
end
