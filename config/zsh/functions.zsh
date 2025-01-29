# Create debug file in current directory. Can be checked to turn on debug mode in scripts.
function debug() {
    # File path for the lock file
    local lock_file="debug.lock"

    # Check if the lock file exists
    if [[ -e "$lock_file" ]]; then
        # Delete the lock file
        rm "$lock_file"
        echo "Lock file deleted."
    else
        # Create the lock file
        touch "$lock_file"
        echo "Lock file created."
    fi
}

function showpath {
    echo $PATH | sed 's/\:/\n/g'
}

# Function to recursively delete .DS_Store files
function delete_ds_store_files() {
    local dir=$1

    # Remove .DS_Store files in the current directory
    find "$dir" -type f -name .DS_Store -exec rm -f {} \;

    # Recursively call the function for subdirectories
    for sub_dir in "$dir"/*(/); do
        delete_ds_store_files "$sub_dir"
    done
}

alias nods="delete_ds_store_files"

function aliases() {
  local alias_name
  for alias_name in ${(k)aliases}; do
    echo "$alias_name -> ${aliases[$alias_name]}"
  done | sort
}

# Type to Siri
function siri(){
    cliclick kd:fn kp:space ku:fn w:250 t:$1 kp:return
}

function chpwd() {
  ls -l
}

config() {
    local config_file

    case "$1" in
        zsh)
            code "$HOME/.zshrc"
            ;;
        vim)
            code "$HOME/.vimrc"
            ;;
        git)
            code "$HOME/.gitconfig"
            ;;
        httpd)
            code /opt/homebrew/etc/httpd/httpd.conf
            ;;
        sites)
            code /opt/homebrew/etc/httpd/sites
            ;;
        hosts)
            sudo nano /etc/hosts
            ;;
        *)
            echo "Usage: config {zsh|vim|git|httpd|hosts}"
            return 1
            ;;
    esac
}

