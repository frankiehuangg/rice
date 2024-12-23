# Setup

## Pre-installation

1. Verify that the system is running on the boot mode (64) with the following command

```console
# cat /sys/firmware/efi/fw_platform_size
```

2. Connect to the internet using `iwctl` (WiFi), and make sure that it's connected with the following command

```console
# ping archlinux.org
```

3. Update the system clock using the following command

```console
# timedatectl
```

4. Wipe out the disk using the following command

```console
# gdisk /dev/[NAME]
```

5. Type `x` for expert mode, `z` to wipe all data and partitions, then `y` when asked

6. Create the partitions using the following command

```console
# cgdisk /dev/[NAME]
```

7. Ignore all Non-GPT or damaged disks warning if detected

8. Create the following partitions:

| Sector Size      | Total Size | Partition Type   | Name   |
| ---------------- | ---------- | ---------------- | ------ |
| `default` (2048) | `512MiB`   | `EF00`           | `boot` |
| `default` (2048) | `64GiB`    | `default` (8300) | `root` |
| `default` (2048) | `default`  | `default` (8300) | `home` |

9. Confirm the partition choice above by choosing the `Write` option, then `yes` when prompted

10. Ensure the partition above is successful with the following command

```console
# lsblk
```

11. Format the partitions above with the following commands

```console
# mkfs.fat -F32 /dev/[NAME]1
# mkfs.ext4 /dev/[NAME]2
# mkfs.ext4 /dev/[NAME]3
```

12. Mount the partitions above with the following commands

```console
# mount /dev/[NAME]2 /mnt
# mkdir /mnt/boot
# mount /dev/[NAME]1 /mnt/boot
# mkdir /mnt/home
# mount /dev/[NAME]3 /mnt/home
```

13. Check if the partitions are mounted correctly with the following command

```console
# lsblk
```

## Installation

1. Backup the default mirrorlist with the following command

```console
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
```

2. Rank the mirrors using the following commands

```console
# pacman -Sy pacman-contrib
# rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
```

3. Install the essential packages with the following command

```console
# pacstrap -K /mnt base linux linux-firmware
```

## System configuration

1. Generate an fstab file with the following command

```console
# genfstab -U /mnt >> /mnt/etc/fstab
```

2. Change root with the following command

```console
# arch-chroot /mnt
```

3. Set to the current timezone with the following command

```console
# ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
# hwclock --systohc --utc
```

4. Download the following packages

```console
# pacman -S sudo neovim bash-completion
```

5. Setup the localization by editting the `/etc/locale.gen` file, then uncomment the `en_US.UTF-8 UTF-8` line

6. Generate the locale with the following command

```console
# locale-gen
# echo LANG=en_US.UTF-8 > /etc/locale.conf
# export LANG=en_US.UTF-8
```

7. Create a hostname for the system using the following command

```console
# echo [NAME] > /etc/hostname
```

8. enable trim support for the SSD with the following command

```console
# systemctl enable fstrim.timer
```

9. Enable 32-bit support for pacman by uncommenting the `[multilib]` lines

10. Set the root password with the following command

```console
# passwd
```

11. Create a user account with the following command

```console
# useradd -m -g users -G wheel,storage,power -s /bin/bash [NAME]
# passwd
```

12. Add the new user to the sudoers file with the following command

```console
# EDITOR=nvim visudo
```

13. Uncomment the `%wheel ALL=(ALL:ALL) ALL` line, then add `Defaults rootpw` in the bottom of the file

14. Enable dynamic host configuration and enable network manager with the following commands

```console
# ip link # find the network card
# pacman -Sy dhcpcd networkmanager
# systemctl enable dhcpcd@[DEV_NAME].service
# systemctl enable NetworkManager.service
```

15. Check if EFI is loaded with the following command

```console
$ mount -t efivarfs efivarfs /sys/firmware/efi/efivars/
```

16. Install the bootloader with the following command

```console
$ bootctl install
```

17. Use `nvim` to open the `/boot/loader/entries/arch.conf` file, then type the following lines inside the file

```
title Arch
linux /vmlinuz-linux
initrd /initramfs-linux.img
```

18. Mount the root partition and enable `rw` to it with the following command

```console
$ echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/[NAME]2) rw" >> /boot/loader/entries/arch.conf
```

19. Check if the command above is appended to the `/boot/loader/entries/arch.conf` file

20. Install the required packages with the following command

```console
$ pacman -S grub efibootmgr
```

21. Install grub on the system with the following command

```console
$ grub-install --target=x86_64-efi --efi-directory=/boot -bootloader-id=GRUB
```

22. Create a grub config file with the following command

```console
$ grub-mkconfig -o /boot/grub/grub.cfg
```

23. Install grub on the boot partition with the following command

```console
$ grub-install /dev/[NAME]
```

24. Reboot the system and grub should be installed

## Installing Desktop Environment

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
$ sudo pacman -S plasma sddm
```

4. Enable sddm with the following command

```console
$ sudo systemctl enable sddm.service
```

5. Reboot the system and DE should be installed

## Configuring Desktop Environment

### Setup Hardware

1. Ensure the `ideapad_laptop` kernel module is loaded with the following command

```console
$ lsmod | grep ideapad_laptop
```

2. Enable battery conservation mode with the following command

```console
# echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
```

3. Install the touchpad synaptics module with the following command

```console
# pacman -S xf86-input-synaptics
```

4. Enable touchpad tap to click by editting the `/etc/X11/xorg.conf.d/70-synaptics.conf` file with the following content

```
Section "InputClass"
   Identifier "touchpad"
   Driver "synaptics"
   MatchIsTouchpad "on"
      Option "TapButton1" "1"
      Option "TapButton2" "3"
      Option "TapButton3" "2"
      Option "VertEdgeScroll" "on"
      Option "VertTwoFingerScroll" "on"
      Option "HorizEdgeScroll" "on"
      Option "HorizTwoFingerScroll" "on"
      Option "CircularScrolling" "on"
      Option "CircScrollTrigger" "2"
      Option "EmulateTwoFingerMinZ" "40"
      Option "EmulateTwoFingerMinW" "8"
      Option "CoastingSpeed" "0"
      Option "FingerLow" "30"
      Option "FingerHigh" "50"
      Option "MaxTapTime" "125"
EndSection
```

5. Download the required packages to setup the Vulkan Graphics Card with the following command

```console
# pacman -S xf86-video-amdgpu vulkan-radeon mesa
```

### Downloading packages

1. Download the following packages with the following command

```console
# pacman -S 7zip base-devel dolphin firefox git gwenview konsole man-db man-pages okular openssh unzip wget
```

2. Install `yay` and download the following packages with the following commands

```console
$ git clone https://aur.archlinux.org/yay.git
$ cd yay && makepkg -si
```

3. Aditionally download the following packages with the following commands

```console
# pacman -S code curl discord docker flameshot gdb htop jq less \
            neofetch python-pycryptodome python-pwntools pwninit \
            qbittorrent sagemath ttf-jetbrains-mono-nerd steam \
            typst vlc wireshark-qt
$ yay -S brave-bin teams zoom
```

### Setup SSH

1. Create a `~/.ssh/config` file with the following content

```
Host account1
   HostName hostName
   User username
   IdentityFile ~/.ssh/path/to/identity/file
   Port 22
```

2. To generate an SSH, run the following code

```console
$ chmod 700 ~/.ssh
$ ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/path/to/host
$ eval $(ssh-agent -s)
$ ssh-add ~/.ssh/path/to/private-key/file
```

### Setup Python venv

1. Run the following code to setup Python venv

```console
$ python -m venv ~/.virtualenvs/
$ echo "source ~/.virtualenvs/bin/activate" >> ~/.bashrc
```

### Setup Docker

### Setup KVM (Virtual Machine Manager)

### Setup Firefox

1. Setup firefox with the following configurations

```
Settings: Search > Default Search Engine > DuckDuckGo
Settings: Search > Search Suggestions > Disable
Settings: Search > Search Shortcuts > Remove all
Settings: Privacy & Security > Cookies and Site Data > Check
Settings: Privacy & Security > History > Only check "Clear history when Firefox closes"
Settings: Privacy & Security > Logins and Passwords > Disable
```

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

#### Finishing Touches

1. Create an empty panel with size 36 with the following widgets:

```
Pager | Panel Spacer | Icons-only Task Manager | Panel Spacer | System Tray | Digital Clock
```

2. Use the following configurations for the panel: Left, Auto Hide, Translucent

3. Use the following configurations for the pager:

- Enable Show only current screen
- Enable Navigation wraps around
- Text display: Desktop name
