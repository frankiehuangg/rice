## Steps

### Pre-installation

1. Verify boot mode `cat /sys/firmware/efi/fw_platform_size`. Make sure it's 64
2. Connect to internet `a` Make sure it's connected `ping archlinux.org`.
3. Ensure clock is accurate using `timedatectl`.
4. Wipe out the disk using `gdisk /dev/[NAME]`. Then type `x` for expert mode, t
hen `z` to wipe all data and partitions. Answer `y` when asked.
5. Next type `cgdisk /dev/[NAME]` and hit `enter` if a Non-GPT or damaged disk w
arning is detected.
6. Partitions:
- First partition
    - Sector size: `default` (2048)
    - Total size: 512MiB
    - Partition type: EF00
    - Name: boot
- Second partition
    - Sector size: `default`
    - Total size: RAM size (RAM >= 4GB)
    - Partition type: 8200
    - Name: swap
- Third partition (optional)
    - Sector size: `default`
    - Total size: 16GiB
    - Partition type: `default`
    - Name: root
- Fourth partition
    - Sector size: `default` (2048)
    - Total size: `default` (the rest)
    - Partition type: `default` (8300)
    - Name: home (root if no third partition)
7. Next, choose the `Write` option, then `yes`. Quit the program by choosing the
`Quit` option. Ensure the partition is successful by viewing it using `lsblk`.
8. Format the partitions
- `mkfs.fat -F32 /dev/[boot]` for the `boot` partition
- `mkswap /dev/[swap]` then `swapon /dev/[NAME]` for the `swap` partition
- `mkfs.ext4 /dev/[root]` for the `root` partition. Hit `y` when prompted.
- `mkfs.ext4 /dev/[home]` for the `home` partition. Hit `y` when prompted.
9. Mount the partitions
- `mount /dev/[root] /mnt` for the `root` partition.
- `mkdir /mnt/boot` then `mount /dev/[boot] /mnt/boot` for the `boot` partition.
- `mkdir /mnt/home` then `mount /dev/[home] /mnt/home` for the `home` partition.
Ensure the partitions are mounted correctly with `lsblk`.

### Installation

1. Backup the default `mirrorlist` with `cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak`
2. Install `rankmirrors` with `pacman -Sy pacman-contrib`
3. Rank the mirrors using `rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist`
4. Install the essential packages with `pacstrap -K /mnt base linux linux-firmware`

### System configuration

1. Generate the `fstab` file with `genfstab -U /mnt >> /mnt/etc/fstab`.
2. Go inside the new system with `arch-chroot /mnt`.
3. Download `sudo`, `nvim`, and `bash-completion` with `pacman -S sudo neovim bash-completion`.
4. Use `nvim` to view the `/etc/locale.gen` file, then uncomment the
`en_US.UTF-8 UTF-8` line. Then save the file and quit the program. Next, generate
the locale with `locale-gen`.
5. Set the `LANG` environment variable with `echo LANG=en_US.UTF-8 > /etc/locale.conf`.
6. Export the `LANG` environment variable with `export LANG=en_US.UTF-8`.
7. Set the time zone with `ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime`.
Next, sync the clock with `hwclock --systohc --utc`
8. Create a host name for the system with `echo [NAME] > /etc/hostname`.
9. Enable trim support for the SSD with `systemctl enable fstrim.timer`.
10. Use `nvim` to enable 32-bit support by modifying the `/etc/pacman.conf` file.
Scroll all the way down and uncomment the 2 `[multilib]` line.
11. Set the `root` password with `passwd` and typing the password twice.
12. Create a user account with
`useradd -m -g users -G wheel,storage,power -s /bin/bash [NAME]`. Set the
password with `passwd [NAME]`.
13. Use `nvim` to modify the sudoers file with `EDITOR=nvim visudo`. Uncomment the
`%wheel ALL=(ALL:ALL) ALL` line then add `Defaults rootpw` in the bottom of the
file.
14. Use `ip link` to find out the network card used by the system. Then download
the `dhcpcd` with `pacman -Sy dhcpcd`. Then enable the service with
`systemctl enable dhcpcd@[DEV_NAME].service`.
15. Download `networkmanager` with `pacman -S networkmanager`, then enable the
service with `systemctl enable NetworkManager.service`.

### Boot loader
1. Make sure EFI are loaded with `mount -t efivarfs efivarfs /sys/firmware/efi/efivars/`.
Check if efi are present with `ls /sys/firmware/efi/efivars/`.
2. Install the bootloader with `bootctl install`.
3. use `nvim` to open the `/boot/loader/entries/arch.conf` file. Type the following lines
inside the file.
```txt
title Arch
linux /vmlinuz-linux
initrd /initramfs-linux.img
```
4. Next, type
`echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/[root]) rw" >> /boot/loader/entries/arch.conf`.
Check if the string above is appended to the `/boot/loader/entries/arch.conf` file.
5. Reboot the system.

### Installing DS/DE
1. Download the required packages `sudo pacman -S xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm`.
Check if it's installed with `startx`.
2. Download `plasma` and `sddm` with `sudo pacman -S plasma sddm`.
3. Enable sddm with `sudo systemctl enable sddm.service`.
4. Reboot the system.

### Configuring KDE

#### Downloading packages

Download the following packages with pacman

```text
base-devel code discord dolphin firefox gdb git konsole htop less openssh python-pycryptodome python-pwntools pwninit sagemath unzip wget wine wireshark-qt
```

Clone `yay` from github, then `cd` to the directory and use `makepkg -si`. 
Next, download the  following packages with `yay`

```text
burpsuite-pro pycdc-git
```

Ensure the following packages are installed (should be installed, but just check
to make sure).

```text
kscreen plasma-nm systemsettings
```

#### System Settings

Download KDE catppuccin themes: `https://github.com/catppuccin/kde`.
Settings: Frappe, Sky, MacOS, then `ln -s ~/.local/share/icons ~/.icons`.

Download SF Mono Fonts: `yay -S nerd-fonts-sf-mono`.
Settings: Text & Fonts > Fonts
- General       : Liga SFMono Nerd Font 10
- Fixed width   : Liga SFMono Nerd Font 10
- Small         : Noto Sans 8pt
- Toolbar       : Noto Sans 10pt
- Menu          : Noto Sans 10pt
- Window title  : Noto Sans 10pt

Settings: Colors & Themes > Splash Screen: Catppuccin Latte Sky

Settings: General Behavior > Clicking files or folders: Selects them

Settings: Window Management > Desktop Effects > Enable blur

Settings: Screen Locking > Lock automatically after 15 minutes

Settings: Window Management > Virtual Desktops > Enable Navigation wraps around, create 3 VDs

#### Finishing Touches

Configure pager:
- Enable Show only current screen.
- Enable Navigation wraps around.
- Text display: Desktop name

#### Further Setup

- Virtual Machine Manager
- rclone
