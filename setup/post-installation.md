# Post Installation Steps

## Downloading packages

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

## Setup Python venv

1. Run the following code to setup Python venv

```console
$ python -m venv ~/.virtualenvs/
$ echo "source ~/.virtualenvs/bin/activate" >> ~/.bashrc
```

## Setup Docker

## Setup KVM (Virtual Machine Manager)

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
