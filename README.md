# SwayWM Config
Meant to be used as the default SwayWM config located at ~/.config/sway.

## Installation of Sway

```shell
sudo apt install sway swaylock swayidle
```

## Installation of Dependencies

```shell
sudo apt install rofi i3blocks kanshi jq
```

```shell
mkdir -p ~/.config/kanshi && touch ~/.config/kanshi/config
git clone git@github.com:J-Pai/i3blocks-contrib.git ~/.config/i3blocks-contrib
ln -s ~/.config/sway/i3blocks ~/.config
```

TODO: Change i3blocks-contrib back to mainline once https://github.com/vivien/i3blocks-contrib/pull/433

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
exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway XDG_SESSION_DESKTOP=sway

exec "ssh-agent -a $SSH_AUTH_SOCK"
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

profile "internal" {
	output eDP-1 mode 1920x1080@59.934Hz position 2560,0
}
```

Workspace forcing (prefer to place in platform specific config):

```shell
workspace 1 output "eDP-1"
workspace 2 output "HDMI-A-1" "eDP-1"
```
