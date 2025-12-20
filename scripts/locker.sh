#!/bin/bash

export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(pgrep -x sway).sock

case $1 in
  screen_off_if_locked)
    if pgrep -x swaylock; then
      swaymsg "output * power off"
    fi
    ;;
  screen_off)
    swaymsg "output * power off"
    ;;
  screen_on)
    swaymsg "output * power on"
    ;;
  *)
    swaylock -f --color "#000000" -i ~/Pictures/winders.gif -s fit
    ;;
esac
