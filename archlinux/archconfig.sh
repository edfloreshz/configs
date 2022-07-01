# Arch Linux Configuration Script
# Author: Eduardo Flores <edfloreshz@gmail.com>

pacman -S dialog --noconfirm --needed

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Arch Linux Configuration Script"
TITLE="Configuration Script"
MENU="Select an option..."

OPTIONS=(
    1 "Install Paru"
    2 "Install developer tools"
    3 "Install programs"
    4 "Install emoji"
    5 "Place dotfiles"
    6 "Maintenance"
)

while CHOICE=$(dialog --clear --cancel-label "Exit" --backtitle "$BACKTITLE" --title "$TITLE" \
        --menu "$MENU" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" \
        2>&1 >/dev/tty)
clear
do
    case $CHOICE in
        1) # Paru installation
            if ! type paru 2>&1 1>/dev/null
            then
                sudo pacman -S --needed --noconfirm base-devel git
                git clone https://aur.archlinux.org/paru.git
                cd paru
                makepkg -si
                cd ..
                rm -rf paru
                echo "Paru installed"
            else
                echo "Paru is already installed."
            fi
            ;;
        2) # Install developer tools
            hash cargo && echo "Rust is already installed" || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
            hash dm && echo "Devmode is already installed" || cargo install devmode
            ;;
        3) # Install programs
            paru -S jetbrains-toolbox visual-studio-code-bin alacritty fish bat exa neovim github-cli --needed --noconfirm
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak install flathub de.haeckerfelix.Fragments org.telegram.desktop com.discordapp.Discord com.valvesoftware.Steam org.videolan.VLC com.obsproject.Studio org.mozilla.Thunderbird com.slack.Slack io.github.mimbrero.WhatsAppDesktop com.getpostman.Postman org.kde.krita com.mongodb.Compass org.gnome.Builder com.rafaelmardojai.Blanket re.sonny.Commit io.bassi.Amberol com.rafaelmardojai.SharePreview dev.edfloreshz.Done org.gnome.Fractal org.gnome.Polari org.gnome.TextEditor org.gnome.design.IconLibrary org.gnome.design.Emblem org.gnome.gitlab.YaLTeR.VideoTrimmer org.kde.neochat
            echo "All programs installed"
            ;;
        4) # Install emoji
            set -e
            if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi
            echo "Setting up Noto Emoji font..."
            # 1 - install  noto-fonts-emoji package
            pacman -S noto-fonts-emoji --needed
            pacman -S powerline-fonts --needed
            # 2 - add font config to /etc/fonts/conf.d/01-notosans.conf
            echo "<?xml version="1.0"?>
            <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
            <fontconfig>
            <alias>
            <family>sans-serif</family>
            <prefer>
                <family>Noto Sans</family>
                <family>Noto Color Emoji</family>
                <family>Noto Emoji</family>
                <family>DejaVu Sans</family>
            </prefer>
            </alias>

            <alias>
            <family>serif</family>
            <prefer>
                <family>Noto Serif</family>
                <family>Noto Color Emoji</family>
                <family>Noto Emoji</family>
                <family>DejaVu Serif</family>
            </prefer>
            </alias>

            <alias>
            <family>monospace</family>
            <prefer>
                <family>Noto Mono</family>
                <family>Noto Color Emoji</family>
                <family>Noto Emoji</family>
                <family>DejaVu Sans Mono</family>
            </prefer>
            </alias>
            </fontconfig>

            " > /etc/fonts/local.conf
            # 3 - update font cache via fc-cache
            fc-cache
            echo "Emoji installed."
            ;;
        5) # Place dotfiles
            git clone https://github.com/edfloreshz/dotfiles
            cd dotfiles
            chmod 755 place.sh 
            ./place.sh 
            cd .. && rm -rf dotfiles
            ;;
        6) # Maintenance
            ./maintenance.sh
            ;;
        *)
            break
            ;;
    esac
done
