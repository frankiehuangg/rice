# Lenovo Hardware Setup

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
