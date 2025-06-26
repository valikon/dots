function tmp -w "mv"
    # If no arguments, cd to /tmp or relevant subfolder
    if test (count $argv) -eq 0
        # Check if we're in a git project or regular directory
        set -l git_root (git rev-parse --show-toplevel 2>/dev/null)

        if test $status -eq 0
            # In a git project - check for project folder
            set -l project_name (basename $git_root)
            set -l project_tmp "/tmp/$project_name"

            if test -d $project_tmp
                cd $project_tmp
                return
            end
        else
            # Not in a git project - check for current directory folder
            set -l current_dir_name (basename $PWD)
            set -l current_tmp "/tmp/$current_dir_name"

            if test -d $current_tmp
                cd $current_tmp
                return
            end
        end

        # No relevant folder found, just go to /tmp
        cd /tmp
        return
    end

    # Determine destination directory
    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
    set -l dest_dir  # Declare dest_dir in the function scope

    if test $status -eq 0
        # In a git project - use the project name
        set -l project_name (basename $git_root)
        set dest_dir "/tmp/$project_name"
    else
        # Not in a git project - use current directory name
        set -l current_dir_name (basename $PWD)
        set dest_dir "/tmp/$current_dir_name"
    end

    # Create destination directory if it doesn't exist
    mkdir -p $dest_dir

    # Move all provided files
    for file in $argv
        if test -e $file
            mv $file $dest_dir/
        end
    end

    if test $status -eq 0
        echo "Moved $argv to $dest_dir"
    end
end

