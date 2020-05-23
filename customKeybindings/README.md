###Setting up Custom Keybinds
Guide: [https://yulistic.gitlab.io/2017/12/linux-keymapping-with-udev-hwdb/](https://yulistic.gitlab.io/2017/12/linux-keymapping-with-udev-hwdb/)

##Steps to install keybinds
1. make sure custom-KEYBOARD.hwdb file is owned by root
2. sudo cp custom-KEYBOARD.hwdb /etc/udev/hwdb.d/
3. sudo systemd-hwdb update
4. sudo udevadm trigger


##Steps to add new devices
*Will Add Eventually*
Refer to guide link above.
