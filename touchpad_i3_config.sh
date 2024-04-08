#!/bin/zsh

# Touchpad configuration

touchpad_id=$(xinput list | ag touchpad | cut -d = -f 2 | awk '{print $1}')

xinput set-prop $touchpad_id 'libinput Tapping Enabled' 1
xinput set-prop $touchpad_id 'libinput Middle Emulation Enabled' 1
xinput set-prop $touchpad_id 'libinput Natural Scrolling Enabled' 1
