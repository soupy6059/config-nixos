# NEOFETCH
          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖            cartera@nixos 
          ▜███▙       ▜███▙  ▟███▛            ------------- 
           ▜███▙       ▜███▙▟███▛             OS: NixOS 24.11.715908.7105ae395770 (Vicuna) x86\_64 
            ▜███▙       ▜██████▛              Host: ASUSTeK COMPUTER INC. K5504VA 
     ▟█████████████████▙ ▜████▛     ▟▙        Kernel: 6.6.83 
    ▟███████████████████▙ ▜███▙    ▟██▙       Uptime: 1 hour, 44 mins 
           ▄▄▄▄▖           ▜███▙  ▟███▛       Packages: 7013 (nix-system), 632 (nix-user) 
          ▟███▛             ▜██▛ ▟███▛        Shell: bash 5.2.37 
         ▟███▛               ▜▛ ▟███▛         Resolution: 1920x1080 
▟███████████▛                  ▟██████████▙   DE: Plasma 6.2.5 (Wayland) 
▜██████████▛                  ▟███████████▛   WM: kwin 
      ▟███▛ ▟▙               ▟███▛            Icons: breeze-dark [GTK2/3] 
     ▟███▛ ▟██▙             ▟███▛             Terminal: .konsole-wrappe 
    ▟███▛  ▜███▙           ▝▀▀▀▀              CPU: 13th Gen Intel i9-13900H (20) @ 5.200GHz 
    ▜██▛    ▜███▙ ▜██████████████████▛        GPU: Intel Raptor Lake-P [Iris Xe Graphics] 
     ▜▛     ▟████▙ ▜████████████████▛         Memory: 2835MiB / 15617MiB 
           ▟██████▙       ▜███▙
          ▟███▛▜███▙       ▜███▙                                      
         ▟███▛  ▜███▙       ▜███▙                                     
         ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘

# TODO
Personally I use the todo script with no arguments, and that's recommended.
The directories have to be set up manually.
The git repository has to be setup manually.

## Step 1: ~/.bashrc editing
add
```bash
alias todo="~/.todo\_script.sh"
```
to your ~/.bashrc

## Step 2: repo setup
```bash
cd Documents
mkdir todo
cd todo
git init
git remote add todo-backups <URL>
git push --set-upstream todo-backups master
```
Note that if change where the todo repo is, then you'll have to update the
paths in todo\_script.sh.

## Step 3: vim alternatives
If you don't use vim, use the vimless\_todo\_script.sh instead, replace 
the tag \<EDITOR\_GOES\_HERE\> with your own editor. Usually nano is
installed by default, so try that first.

## Step 4: reminders (optional)
Add 
```bash
todays_date=$(date +"%Y%m%d")

if [[ ! -f ~/Documents/todo/todo_${todays_date}.md ]]; then
    echo "Consider running todo"
fi
```
to your ~/.bashrc if you want to be reminded that you don't have a todo
file for that day.
