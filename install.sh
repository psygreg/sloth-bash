#!/usr/bin/env bash
set -euo pipefail

REPO_RAW="${SLOTH_BASH_RAW_BASE:-https://raw.githubusercontent.com/psygreg/sloth-bash/main}"

# Argument parsing: Check if called from app
APP_MODE=false
for arg in "$@"; do
    case "$arg" in
        --from-app)
            APP_MODE=true
            ;;
    esac
done

# If called from app and SCRIPT_DIR is set, source shared libraries
if [[ "$APP_MODE" == true ]] && [[ -n "${SCRIPT_DIR:-}" ]] && [[ -f "$SCRIPT_DIR/libs/linuxtoys.lib" ]]; then
    # shellcheck source=/dev/null
    source "$SCRIPT_DIR/libs/linuxtoys.lib"
fi

download() {
    local url="$1" dest="$2"
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$dest"
    elif command -v wget >/dev/null 2>&1; then
        wget -q -O "$dest" "$url"
    else
        echo "Need curl or wget to download $url" >&2
        return 1
    fi
}

download_if_missing() {
    local url="$1" dest="$2"
    if [[ -e "$dest" ]]; then
        echo "Keeping existing $dest"
        return 0
    fi
    mkdir -p "$(dirname -- "$dest")"
    download "$url" "$dest"
}

header() {
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⠤⠴⠖⠚⠛⠉⠉⠉⠀⠀ "
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⢰⣸⣶⣇⠀⢰⣿⣿⣷⣤⠤⠴⠖⠒⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⣀⣀⣤⠤⠶⠀  "
    echo "⠀⠀⠀⠀⠀⠀⠀⢀⣰⣴⣇⠀⢰⣾⣿⣄⣼⡿⠿⢿⡟⠛⠉⠉⠁⠀⠀⠀⠀⠀⠀⣀⣀⣠⠤⠤⠖⠚⠛⠉⠉⠀⠀⠀⠀  "
    echo "⠀⠀⠀⠀⣀⣠⣤⢾⣿⠽⢼⡛⠋⠉⠉⠁⢸⠀⠀⠈⢻⣄⣀⣠⠤⠤⣶⠒⠚⠋⢉⣉⣠⣤⠤⠤⠤⣤⣀⠀⠀⠀⠀⠀⠀⠀ "
    echo "⠀⠟⠋⠉⠉⠀⠀⣾⠃⠀⠈⢻⣀⣠⠤⢤⣿⠀⠀⠀⠀⢿⡇⠀⢀⣤⡿⠗⠒⢚⣏⠉⠱⡄⠀⠀⠀⢸⠈⠙⠲⣄⠀⠀⠀⠀ "
    echo "⠀⣤⣀⣀⡤⠤⠶⡿⠀⠀⠀⠀⣿⠀⠀⠀⢿⠀⠀⠀⠀⠘⣇⣴⠃⠀⠻⢤⡸⣿⡿⠏⢀⡿⠀⠀⢠⣏⡀⠀⠀⠈⢷⡀⠀⠀ "
    echo "⠀⠉⠁⠀⠀⠀⢰⡇⠀⠀⠀⠀⠸⡆⠀⠀⢸⡁⠀⠀⠀⠀⢹⡏⠀⠀⠀⣰⣿⣗⠓⠒⠛⠀⠀⠀⠀⠀⠉⠓⢦⡀⠀⢳⡄⠀ "
    echo "⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢳⠒⠒⢙⡇⠀⠀⠀⠀⠀⣧⠀⠀⠀⢿⣧⣽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡀⠀⢷⠀ "
    echo "⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠈⠁⠀⠘⠃⠀⠀⠀⠀⠀⢻⡀⠀⠀⠈⠛⠛⠀⣠⠞⡉⠉⠳⣄⠀⠀⠀⠀⠀⢳⠀⠘⡇ "
    echo "⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⠀⠀⠀⠀⠀⢠⠇⣴⣿⣷⠀⠸⡆⠀⠀⠀⠀⢸⠀⠀⡇ "
    echo "⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⢸⡄⠉⠋⠉⠀⠀⢷⠀⠀⠀⠀⣸⠀⢠⡇ "
    echo "⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⢸⠀⠀⠀⣰⠃⠀⡼⠀ "
    echo "⠀⠀⠀⠀⠀⠀⠀⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⡀⢀⠇⠀⠀⠀⠀⠀⠀⣸⠀⣠⠞⠁⠀⡼⠃⠀ "
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠾⣄⣀⡀⢀⣀⣀⡠⠷⠚⠁⠀⣠⠞⠁ "
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠁⠀⠀⠀⢀⣠⠞⠃⠀⠀⠀⠀ "
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠖⠋⠁⠀⠀⠀⠀⠀⠀ "
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⠴⠒⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
    echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠒⠲⠤⠤⠤⠤⠤⠤⠦⠶⠖⠚⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ "
    echo "      _       _   _           _               _      "
    echo "     | |     | | | |         | |             | |     "
    echo "  ___| | ___ | |_| |__ ______| |__   __ _ ___| |__   "
    echo " / __| |/ _ \\| __| '_ \\______| '_ \\\\ / \`_ / __| '_ \\\\  "
    echo " \\__ \\ | (_) | |_| | | |     | |_) | (_| \\__ \\ | | | "
    echo " |___/_|\\___/ \\__|_| |_|     |_.__/ \\__,_|___/_| |_| "
    echo
}

header
show_menu() {
    local choice
    if [[ -f ~/.sloth-bash ]]; then
        echo "What would you like to do?"
        echo
        echo "1) Install or update sloth-bash"
        echo "2) Remove sloth-bash"
        echo "3) Exit"
        echo
        read -rp "Enter your choice (1-3): " choice < /dev/tty
        case "$choice" in
            1) return 0 ;;
            2) return 1 ;;
            3)
                echo "Ok, bye!"
                exit 100
                ;;
            *)
                echo "Invalid choice. Please try again."
                show_menu
                ;;
        esac
    else
        echo "Ready to become a Sloth? 🦥"
        echo
        echo "1) Install sloth-bash"
        echo "2) Exit"
        echo
        read -rp "Enter your choice (1-2): " choice < /dev/tty
        case "$choice" in
            1) return 0 ;;
            2)
                echo "Ok, bye!"
                exit 100
                ;;
            *)
                echo "Invalid choice. Please try again."
                show_menu
                ;;
        esac
    fi
}
show_menu
action=$?

remove_source_lines() {
    local file="$1"
    [[ -f "$file" ]] || return 0
    # portable-ish in-place delete of source lines
    local tmp
    tmp=$(mktemp)
    grep -v 'source ~/.sloth-bash' "$file" > "$tmp" || true
    mv "$tmp" "$file"
}

if [[ $action -eq 1 ]]; then
    echo "Removing sloth-bash..."
    rm -f ~/.sloth-bash
    # Keep ~/.alias-list and starship.toml — user customizations
    remove_source_lines ~/.bashrc
    remove_source_lines ~/.profile
    echo "sloth-bash has been removed."
    echo "Note: ~/.alias-list, ~/.config/starship.toml, Starship, and fzf were left in place."
    exit 0
fi

if ! command -v starship >/dev/null 2>&1; then
    if command -v sudo >/dev/null 2>&1; then
        sudo mkdir -p /usr/local/bin
        if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
            export PATH="/usr/local/bin:$PATH"
            if [[ -f ~/.bashrc ]] && ! grep -q '/usr/local/bin' ~/.bashrc; then
                echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
            fi
        fi
        curl -fsS https://starship.rs/install.sh | sh
    else
        echo "Starship is not installed and sudo is unavailable; skipping Starship install."
    fi
fi

if [[ "$APP_MODE" == true ]]; then
    pkg_install fzf
else
    if ! command -v fzf >/dev/null 2>&1; then
        # shellcheck source=/dev/null
        source <(curl -fsS https://raw.githubusercontent.com/psygreg/linuxtoys/master/p3/libs/linuxtoys.lib)
        pkg_install fzf --ignore-appends
    fi
fi

# Core script always updates; user config files are preserved when present.
download "$REPO_RAW/sloth-bash" ~/.sloth-bash
download_if_missing "$REPO_RAW/alias-list" ~/.alias-list
mkdir -p ~/.config
download_if_missing "$REPO_RAW/starship.toml" ~/.config/starship.toml

if [[ -f ~/.bashrc ]]; then
    if ! grep -q 'source ~/.sloth-bash' ~/.bashrc; then
        echo 'source ~/.sloth-bash' >> ~/.bashrc
    fi
else
    if [[ -f ~/.profile ]] && ! grep -q 'source ~/.sloth-bash' ~/.profile; then
        echo 'source ~/.sloth-bash' >> ~/.profile
    elif [[ ! -f ~/.profile ]]; then
        echo 'source ~/.sloth-bash' >> ~/.bashrc
    fi
fi

echo "sloth-bash installed. Open a new shell or run: source ~/.sloth-bash"
