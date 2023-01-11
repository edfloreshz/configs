abbr -a e hx
abbr -a o xdg-open
abbr -a cg cargo
abbr -a c clear
abbr -a ff freshfetch
abbr -a g git
abbr -a gs git status
abbr -a gc git commit
abbr -a gf git fetch
abbr -a gp git push
abbr -a gpl git pull
abbr -a ga git add
abbr -a gsw git switch
abbr -a gck git checkout
abbr -a gl git log --oneline
abbr -a gr git rebase
abbr -a gri git rebase -i
abbr -a grc git rebase --continue

set -U fish_user_paths /home/eduardo/.cargo/bin $fish_user_paths 

if command -v paru > /dev/null
    abbr -a i paru -S
    abbr -a r paru -R
    abbr -a k paru -Rscn
    abbr -a u paru
else if command -v pacman > /dev/null
    abbr -a i sudo pacman -S
    abbr -a r sudo pacman -R
    abbr -a k sudo pacman -Rscn
    abbr -a u sudo pacman -Syu
else
    abbr -a i sudo apt install
    abbr -a r sudo apt remove
    abbr -a k sudo apt remove --purge
    abbr -a f sudo apt update
    abbr -a u sudo apt upgrade
end

if command -v exa > /dev/null
    abbr -a l 'exa --git'
    abbr -a ls 'exa --git'
    abbr -a ll 'exa -l --git'
    abbr -a lll 'exa -la --git'
else 
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

if command -v bat > /dev/null
    abbr -a cat bat
else 
    abbr -a cat cat
end

