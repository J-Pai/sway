#!/bin/bash

while true; do
     waybar $@ --log-level debug >| /tmp/waybar.log
done
