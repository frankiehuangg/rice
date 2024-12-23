# Arch Setup

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
