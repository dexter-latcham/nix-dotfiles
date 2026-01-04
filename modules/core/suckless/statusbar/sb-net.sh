#!/usr/bin/env bash

wifi=󰖩
eth=󰈁
noWifi=󰖪
#noEth=󰈂


connIcon=$noWifi
if [ "$(cat /sys/class/net/w*/operstate 2> /dev/null)" = "up" ]; then
  connIcon=$wifi
else
  if [ "$(cat /sys/class/net/e*/operstate 2> /dev/null)" = "up" ]; then
    connIcon=$eth
  fi
fi

echo "^C4^ $connIcon"
