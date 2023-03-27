# SwayWM Config
Meant to be used as the default SwayWM config located at ~/.config/sway.

## Installation of Sway

```shell
sudo apt install sway swaylock swayidle
```

## Installation of Dependencies

```shell
sudo apt install i3blocks kanshi jq
```

```shell
mkdir -p ~/.config/kanshi && touch ~/.config/kanshi/config
ln -s ~/.config/sway/i3blocks ~/.config
```

## Google Internal

Set up `SSH_AUTH_SOCK`.

```shell
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

Example Kanshi config (~/.config/kanshi/config)

```shell
profile "multiple" {
	output eDP-1 mode 1920x1080@59.934Hz position 2560,0
	output HDMI-A-1 mode 2560x1440@59.951Hz position 0,0
}

profile "multiple" {
	output eDP-1 mode 1920x1080@59.934Hz position 2560,0
	output HDMI-A-1 mode 2560x1440@59.951Hz position 0,0
}
```

Workspace forcing (prefer to place in platform specific config):

```shell
workspace 1 output "HDMI-A-1" "eDP-1"
workspace 2 output "eDP-1"
```
