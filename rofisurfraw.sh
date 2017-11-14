#!/usr/bin/env bash
# Depends on rofi | surfraw | firefox
surfraw -browser=firefox $(sr -elvi | awk -F'-' '{print $1}' | sed '/:/d' | awk '{$1=$1};1' | rofi -kb-row-select "Tab" -kb-row-tab "Control+space" -color-window "#3F8AC2, #3F8AC2, #3F8AC2" -color-normal "#3F8AC2, #ffffff, #3F8AC2, #ffffff, #3F8AC2" -color-active "#3F8AC2, #ffffff, #3F8AC2, #ffffff, #000000" -color-urgent "#3F8AC2, #000000, #3F8AC2, #000000, #3F8AC2" -dmenu -mesg ">>> Tab = Autocomplete" -i -p "websearch: ")
