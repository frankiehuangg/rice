# KDE Setup

## Installing KDE

1. Download X11 with the following command

```console
$ sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm
```

2. Check if X11 is installed with the following command

```console
$ startx
```

3. Download KDE plasma with the following command

```console
$ sudo pacman -S plasma-desktop sddm-kcm kscreen plasma-pa plasma-nm
```

4. Enable sddm with the following command

```console
$ sudo systemctl enable sddm.service
```

5. Reboot the system and DE should be installed

## Configuring KDE

### System Settings

1. Use the KDE catppuccin themes with the following commands

```console
$ git clone --depth=1 https://github.com/catppuccin/kde
$ cd catppuccin-kde
$ ./install.sh # Latte, Sky, MacOS
$ ln -s ~/.local/share/icons ~/.icons
```

2. Use the following settings theme

```
Appearance & Style > Colors & Themes > Colors: Breeze Light
Appearance & Style > Colors & Themes > Application Style: Breeze
Appearance & Style > Colors & Themes > Plasma Style: Breeze
Appearance & Style > Colors & Themes > Window Decorations: Breeze
Appearance & Style > Colors & Themes > Cursor: Breeze
Appearance & Style > Colors & Themes > System Sounds: Ocean
Appearance & Style > Colors & Themes > Splash Screen: Catppuccin Latte Sky
Appearance & Style > Colors & Themes > Login Screen (SDDM): Breeze
```

3. Change the system fonts in Appearance & Style > Text & Fonts > Fonts with the following configurations:

| Type         | Font                         |
| ------------ | ---------------------------- |
| General      | JetBrainsMono Nerd Font 10pt |
| Fixed Width  | JetBrainsMono Nerd Font 10pt |
| Small        | JetBrainsMono Nerd Font 8pt  |
| Toolbar      | JetBrainsMono Nerd Font 10pt |
| Menu         | JetBrainsMono Nerd Font 10pt |
| Window Title | JetBrainsMono Nerd Font 10pt |

4. Change the following workspace behaviours

```
Input & Output > Keyboard > Shortcuts > Emoji Selector: Meta+.
Input & Output > Keyboard > Shortcuts > Flameshot: Meta+Print
Input & Output > Keyboard > Shortcuts > Konsole: Meta+Return
Apps & Windows > Default Applications > Web browser: Firefox
Apps & Windows > Default Applications > Image viewer: Gwenview
Apps & Windows > Default Applications > Text editor: Neovim
Apps & Windows > Default Applications > PDF viewer: Okular
Apps & Windows > Default Applications > File manager: Dolphin
Apps & Windows > Default Applications > Terminal emulator: Konsole
Apps & Windows > Window Management > Virtual Desktops: Create 5 VDs
Workspace > General Behavior > Clicking files or folders: Selects them
Security & Privacy > Screen Locking > 15 minutes
System > Autostart: Flameshot
```

### Finishing Touches

1. Create an empty panel with size 36 with the following widgets:

```
Pager | Panel Spacer | Icons-only Task Manager | Panel Spacer | System Tray | Digital Clock
```

2. Use the following configurations for the panel: Left, Auto Hide, Translucent

3. Use the following configurations for the pager:

- Enable Show only current screen
- Enable Navigation wraps around
- Text display: Desktop name
