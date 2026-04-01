#!/usr/bin/env bash
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
    echo " / __| |/ _ \| __| '_ \______| '_ \\ / \`_ / __| '_ \\  "
    echo " \__ \ | (_) | |_| | | |     | |_) | (_| \__ \ | | | "
    echo " |___/_|\___/ \__|_| |_|     |_.__/ \__,_|___/_| |_| "
    echo
}

header
show_menu() {
    local choice
    if [[ -f ~/.sloth-bash ]]; then
        echo "Sloth-bash already installed. What would you like to do?"
        echo
        echo "1) Update sloth-bash"
        echo "2) Remove sloth-bash"
        echo "3) Exit"
        echo
        read -rp "Enter your choice (1-3): " choice < /dev/tty
        case "$choice" in
            1)
                return 0  # Update
                ;;
            2)
                return 1  # Remove
                ;;
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
            1)
                return 0  # Install
                ;;
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

sudo -v
if [[ $action -eq 1 ]]; then
    echo "Removing sloth-bash..."
    rm -f ~/.sloth-bash ~/.alias-list
    if [[ -f ~/.bashrc ]]; then
        sed -i '/source ~\/.sloth-bash/d' ~/.bashrc
    fi
    if [[ -f ~/.profile ]]; then
        sed -i '/source ~\/.sloth-bash/d' ~/.profile
    fi
    echo "sloth-bash has been removed."
    exit 0
fi
if ! which starship > /dev/null; then
    sudo mkdir -p /usr/local/bin
    curl -sS https://starship.rs/install.sh | sh
fi
wget -O ~/.sloth-bash https://raw.githubusercontent.com/psygreg/sloth-bash/main/sloth-bash
wget -O ~/.alias-list https://raw.githubusercontent.com/psygreg/sloth-bash/main/alias-list
wget -O ~/.config/starship.toml https://raw.githubusercontent.com/psygreg/sloth-bash/main/starship.toml
if [[ -f ~/.bashrc ]]; then
    if ! grep -q "source ~/.sloth-bash" ~/.bashrc; then
        echo "source ~/.sloth-bash" >> ~/.bashrc
    fi
else
    if ! grep -q "source ~/.sloth-bash" ~/.profile; then
        echo "source ~/.sloth-bash" >> ~/.profile
    fi
fi