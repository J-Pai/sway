# SwayWM Config
Meant to be used as the default SwayWM config located at ~/.config/sway.

## Installation of Sway

```shell
sudo apt install sway swaylock swayidle
```

## Installation of Dependencies

```shell
sudo apt install rofi waybar

ln -s ~/.config/sway/waybar ~/.config
```

### Volume Control

```shell
git clone https://github.com/hastinbe/i3-volume.git ~/.config/i3-volume
```

## Google Internal

Set up `SSH_AUTH_SOCK`.

```
mkdir -p ~/.config/environment.d
touch ~/.config/environment.d/envvars.conf

```

Add the following to `envvars.conf`.

```shell
SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket
```

Create a `60-google.conf` file.

```shell
sudo touch /etc/sway/config.d/60-google.conf
```

Add the following to the newly create `60-google.conf` file.

```shell
exec "ssh-agent -a $SSH_AUTH_SOCK"
exec nm-applet --indicator
exec env XDG_CURRENT_DESKTOP=gnome /usr/share/goobuntu-indicator/goobuntu_indicator.py
```

## Display Configuration

```shell
sudo apt install wdisplays
swaymsg -t get_outputs
```

Example config (prefer to place in platform specific config):

```shell
output "DP-3" {
    mode 3840x2160@59.997Hz
    pos 0 0
    scale 1.101562
    scale_filter linear
}

output "DP-4" {
    mode 3840x2160@59.997Hz
    pos 3485 0
    scale 1
    scale_filter nearest
}

workspace 1 output "DP-3"
workspace 2 output "DP-4"
```
