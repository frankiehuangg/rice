# Post Installation Steps

## Downloading packages

1. Download the following packages with the following command

```console
# pacman -S 7zip base-devel firefox git gwenview kitty man-db man-pages okular openssh unzip wget
```

2. Install `yay` and download the following packages with the following commands

```console
$ git clone https://aur.archlinux.org/yay.git
$ cd yay && makepkg -si
```

3. Aditionally download the following packages with the following commands

```console
# pacman -S bluedevil btop code curl discord docker flameshot gdb jq \
    less neofetch python-pycryptodome python-pwntools pwninit \
	qbittorrent sagemath ttf-jetbrains-mono-nerd steam vlc wireshark-qt
```

## Setup SSH

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

3. Additionally, modify the `.gitconfig` file in the home directory with the following content

```
[user]
	name = yourname
	email = your.email@example.com

[core]
	editor = nvim
	autocrlf = input
	ignorecase = true

[color]
	ui = auto

[alias]
	st = status
	co = checkout
	br = branch
	ci = commit
	lg = log --oneline --graph --decorate

[pull]
	rebase = true

[push]
	default = simple

[merge]
	tool = vimdiff

[diff]
	tool = vimdiff
```

## Setup Python venv

1. Setup the Python's venv with the following command

```console
$ python -m venv ~/.virtualenvs/
```

2. Add an alias for easy-switching to the `~/.bashrc` file with the following contents

```
alias venv='source ~/.virtualenvs/bin/activate'
```

## Setup Docker

1. Download and run docker with the following commands

```console
# pacman -S docker
# systemctl start docker.service
# systemctl enable docker.service
```

2. Add the current user to the docker group with the following commands

```console
# groupadd docker
# usermod -aG docker $USER
```

3. Additionally, change the docker images location by editting the `/etc/docker/daemon.json` file with the following contents

```json
{
  "data-root": "/path/to/new/docker/images/directory"
}
```

## Setup KVM (Virtual Machine Manager)

1. Download the required packages with the following commands

```console
# pacman -S qemu-full virt-manager virt-viewer dnsmasq bridge-utils \
			libguestfs iptables vde2 openbsd-netcat swtpm
```

2. Start and enable the libvirtd service with the following commands

```console
# systemctl start libvirtd.service
# systemctl enable libvirtd.service
```

3. Enable virsh by default with the following commands

```console
# virsh net-start
# virsh net-autostart
```

4. Locate and uncomment the following lines in the `/etc/libvirt/libvirtd.conf` file

```
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
```

5. Add the current user to the libvirt group with the following command

```console
# usermod -aG libvirt $USER
```

To install Windows 11 on KVM, please refer to the following guide
- https://sysguides.com/install-a-windows-11-virtual-machine-on-kvm
- https://sysguides.com/share-files-between-the-kvm-host-and-windows-guest-using-virtiofs

## Setup Firefox

1. Setup firefox with the following configurations

```
Settings: Search > Default Search Engine > DuckDuckGo
Settings: Search > Search Suggestions > Disable
Settings: Search > Search Shortcuts > Remove all
Settings: Privacy & Security > Cookies and Site Data > Check
Settings: Privacy & Security > History > Only check "Clear history when Firefox closes"
Settings: Privacy & Security > Logins and Passwords > Disable
```

