# SwayWM Config

![alt text](.image/waybar.png)

## General Environment Setup

```shell
mkdir -p ~/.config/environment.d
touch ~/.config/environment.d/envvars.conf
sudo touch /usr/share/wayland-sessions/sway-env.desktop
sudo touch /usr/bin/sway-env
sudo chmod +x /usr/bin/sway-env
```

Add the following to `/usr/share/wayland-sessions/sway-env.desktop`.

```shell
[Desktop Entry]
Name=Sway (env)
Comment=An i3-compatible Wayland compositor
Exec=sway-env
Type=Application
```

Add the following to `/usr/bin/sway-env`.

```shell
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=gnome

sway
```

Add the following to `/usr/share/wayland-sessions/sway-env.desktop`.

## Registering Sway with GDM (Nvidia)

Add the following to `/usr/share/wayland-sessions/sway-env.desktop`.

```shell
[Desktop Entry]
Name=Sway (nvidia)
Comment=An i3-compatible Wayland compositor
Exec=sway-nvidia
Type=Application
```

Add the following to `/usr/bin/sway-nvidia`.

```shell
cp -f /tmp/sway.log /tmp/sway.log.old

env \
WLR_NO_HARDWARE_CURSORS=1 \
WLR_RENDERER=vulkan \
GBM_BACKEND=nvidia-drm \
sway --unsupported-gpu -Dnoscanout -d |& tee /tmp/sway.log
```

## Dependencies

### Fedora

```shell
sudo dnf install waybar \
    pgrep \
    rofi \
    kanshi \
    jq \
    grimshot \
    wdisplays \
    mako \
    lxqt-policykit \
    qpwgraph
```

### Idle Hack

NOTE: This might no longer be necessary.

swayidle does not seem to detect when browsers send inhibit idle.

Using the following project to enable a service which listens for dbus events
that prevent idling.

https://github.com/loops/idlehack

### Support Multi-Monitor Login with GDM

Download the zip for https://github.com/derflocki/multi-monitor-login?tab=readme-ov-file.

```
sudo mv ~/Downloads/multi-monitor-login-main.zip /opt
sudo machinectl shell gdm@ /bin/bash
dconf reset -f /
gnome-extensions install /opt/multi-monitor-login-main.zip
gsettings set org.gnome.shell enabled-extensions "['multi-monitor-login@derflocki.github.com']"
```

## Disabling Logitech c930e Webcam Microphone

Identify idVendor and idProduct.

```shell
lsusb | grep "Logitech"
```

Create/update `/etc/udev/rules.d/90-block-logitech-sound.rules`.

```shell
# Block Logitech c930e Webcam Microphone
SUBSYSTEM=="usb", DRIVER=="snd-usb-audio", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="0843", ATTR{authorized}="0"
```

Reload udev rules.

```
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## Platform Specific Modifications

Add the following to `~/.config/environment.d/envvars.conf`.

```shell
SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket
```

Create a `60-display.conf` file.

```shell
touch ~/.config/sway/config.d/60-display.conf
```

Use the following as an example for "system" sepcific configuration.

Add the following to the newly create `60-display.conf` file.

```shell
exec --no-startup-id nm-applet
exec --no-startup-id blueman-applet

workspace 1 output DP-1
workspace ~ output DP-2

assign [title=".*Signal"] ~
exec signal-desktop
assign [title=".*Discord"] ~

for_window [title=".*Default - Wine desktop.*"] move to workspace 5
for_window [class=".*gta5.*"] move to workspace 5
for_window [class=".*steam_app_.*"] move to workspace 5
for_window [class=".*factorio.*"] move to workspace 5
for_window [app_id=".*factorio.*"] move to workspace 5

output HEADLESS-1 {
    pos 0,3000
    mode 1920x1080
    adaptive_sync off
}

workspace headless output HEADLESS-1
```

## Configuring Displays

Adjust displays to desired configuration. Apply the configuration, and then
use `get_outputs` to obtain information for Kanshi config.

```shell
wdisplays
swaymsg -t get_outputs
```

Example Kanshi config:

~/.config/kanshi/config

```shell
profile multiple {
    output DP-1 mode 3840x2160 enable position 0,400 adaptive_sync off
    output DP-2 mode 2560x1440 enable position 3840,0 transform 270 adaptive_sync off
    output HDMI-A-1 mode 1280x720 disable
}

profile multiple-headless {
    output DP-1 mode 3840x2160 enable position 0,400 adaptive_sync off
    output DP-2 mode 2560x1440 enable position 3840,0 transform 270 adaptive_sync off
    output HDMI-A-1 mode 1280x720 disable
    output HEADLESS-1 mode 1920x1080 enable position 0,3000 adaptive_sync off
}

profile multiple-headless-off {
    output DP-1 mode 3840x2160 enable position 0,400 adaptive_sync off
    output DP-2 mode 2560x1440 enable position 3840,0 transform 270 adaptive_sync off
    output HDMI-A-1 mode 1280x720 disable
    output HEADLESS-1 mode 1920x1080 disable
}

profile secondary {
    output DP-1 mode 3840x2160 disable
    output DP-2 mode 2560x1440 enable position 3840,0 transform 270 adaptive_sync off
    output HDMI-A-1 mode 1280x720 disable
}

profile secondary-headless {
    output DP-1 mode 3840x2160 disable
    output DP-2 mode 2560x1440 enable position 3840,0 transform 270 adaptive_sync off
    output HDMI-A-1 mode 1280x720 disable
    output HEADLESS-1 mode 1920x1080 enable position 0,3000 adaptive_sync off
}

profile secondary-headless-off {
    output DP-1 mode 3840x2160 disable
    output DP-2 mode 2560x1440 enable position 3840,0 transform 270 adaptive_sync off
    output HDMI-A-1 mode 1280x720 disable
    output HEADLESS-1 mode 1920x1080 disable
}

profile kvm {
    output DP-1 mode 3840x2160 disable
    output DP-2 mode 2560x1440 disable
    output HDMI-A-1 mode 1280x720 enable position 0,6000 adaptive_sync off
}

profile kvm-headless {
    output DP-1 mode 3840x2160 disable
    output DP-2 mode 2560x1440 disable
    output HDMI-A-1 mode 1280x720 enable position 0,6000 adaptive_sync off
    output HEADLESS-1 mode 1920x1080 enable position 0,3000 adaptive_sync off
}

profile kvm-headless-off {
    output DP-1 mode 3840x2160 disable
    output DP-2 mode 2560x1440 disable
    output HDMI-A-1 mode 1280x720 enable position 0,6000 adaptive_sync off
    output HEADLESS-1 mode 1920x1080 disable
}
```

With Nvidia, it's recommended to disable adaptive_sync.

### Launching a headless window

```shell
swaymsg create_output HEADLESS-1
```

Moving windows to a headless workspace.

```shell
swaymsg [class="steam"] move to workspace headless
```

### Setting up Waybar

```shell
ln -sfn ~/.config/sway/waybar ~/.config/waybar
```

## Other Notes

Steam launch options:

```bash
gamescope -f --mangoapp -- %command%
obs-gamecapture %command%
env OBS_VKCAPTURE=1 %command%
mangohud %command%
LD_PRELOAD="" VK_LOADER_LAYERS_ENABLE=VK_LAYER_MANGOHUD_overlay_x86_64 mangohud %command%
```
