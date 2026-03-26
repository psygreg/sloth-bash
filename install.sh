#!/usr/bin/env bash
read -rp "Wanna be a Sloth? (y/n) " answer
if [[ "${answer,,}" != "y" ]]; then
    echo "Ok, bye!"
    exit 0
fi
sudo -v
if ! which starship > /dev/null; then
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