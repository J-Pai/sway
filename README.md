# SwayWM Config
Meant to be used as the default SwayWM config located at ~/.config/sway.

## Installation of Sway

```shell
sudo apt install sway swaylock swayidle
```

## Installation of Dependencies

```shell
sudo apt install i3blocks kanshi jq grimshot
```

```shell
mkdir -p ~/.config/kanshi && touch ~/.config/kanshi/config
git clone git@github.com:J-Pai/i3blocks-contrib.git ~/.config/i3blocks-contrib
ln -s ~/.config/sway/i3blocks ~/.config
```

TODO: Change i3blocks-contrib back to mainline once https://github.com/vivien/i3blocks-contrib/pull/433

Setup other environment variables.

```shell
mkdir -p ~/.config/environment.d
touch ~/.config/environment.d/envvars.conf
```

Add the following to `envvars.conf`.

```shell
XDG_CURRENT_DESKTOP=sway
```

### Setup bemenu

```shell
sudo apt install scdoc wayland-protocols libcairo-dev libpango1.0-dev libxkbcommon-dev libwayland-dev
mkdir -p ~/github && cd ~/github
wget https://github.com/Cloudef/bemenu/releases/download/0.6.14/bemenu-0.6.14.tar.gz
tar -xvf bemenu-0.6.14.tar.gz
cd bemenu-0.6.14.tar.gz

make clients wayland
sudo make install
```

## Platform Specific Modifications

Set up `SSH_AUTH_SOCK`.

Add the following to `envvars.conf`.

```shell
SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket
```

Create a `60-display.conf` file.

```shell
sudo touch /etc/sway/config.d/60-display.conf
```

Add the following to the newly create `60-display.conf` file.

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

Workspace forcing (prefer to place in /etc/sway/config.d/60-display.conf):

```shell
workspace 1 output "eDP-1"
workspace 2 output "HDMI-A-1" "eDP-1"
```
### Nvidia Launcher

```shell
sudo cp ~/.config/sway/nvidia/sway-nvidia.desktop /usr/share/wayland-sessions/sway-nvidia.desktop
sudo cp ~/.config/sway/nvidia/sway-nvidia /usr/bin/sway-nvidia
```

## Keychron K2 Configuration

Prefer to use Apple mode since Windows mode FN keys are broken.

https://schnouki.net/post/2019/how-to-use-a-keychron-k2-usb-keyboard-on-linux/

## Lock Applications to Workspace

Prefer to place in /etc/sway/config.d/60-display.conf.

Prefer to use `class` for filtering. This will ensure only the application
(and not other applications with similar names) will be launched in the correct window

Examples:

```shell
workspace 9 output "HDMI-A-1" "eDP-1"
assign [class=".*Signal"] 9
exec signal-desktop
assign [class=".*steam_app_.*"] 10
assign [class=".*factorio.*"] 10
```
