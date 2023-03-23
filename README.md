# SwayWM Config
Meant to be used as the default SwayWM config located at ~/.config/sway.

## Installation of Sway

```shell
sudo apt install sway swaylock swayidle
```

## Installation of Dependencies

```shell
sudo apt install rofi
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
