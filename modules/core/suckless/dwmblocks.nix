{ config, pkgs, lib, ... }:
let
	batScript = pkgs.writeShellScriptBin "sb-bat" ''
#!/bin/sh
# Display the current battery status.

notify() {
    notify-send \
        --icon=battery-good-symbolic \
        --expire-time=4000 \
        --hint=string:x-canonical-private-synchronous:battery \
        "Battery" "$1"
}

case "$BLOCK_BUTTON" in
    1) notify "$(acpi -b | awk -F ': |, ' '{printf "%s\n%s\n", $2, $4}')" ;;
    6) terminal -e "$EDITOR" "$0" ;;
esac

color=14

# Loop through all attached batteries.
for battery in /sys/class/power_supply/BAT?*; do
    # If non-first battery, print a space separator.
    [ -n "''${capacity+x}" ] && printf " "

    capacity="$(cat "$battery/capacity" 2>&1)"
    if [ "$capacity" -gt 90 ]; then
        status=" "
    elif [ "$capacity" -gt 60 ]; then
        status=" "
    elif [ "$capacity" -gt 40 ]; then
        status=" "
    elif [ "$capacity" -gt 10 ]; then
        status=" "
    else
        status=" "
    fi

    case "$(cat "$battery/status" 2>&1)" in
        Full) status=" " ;;
        Discharging)
            if [ "$capacity" -le 20 ]; then
                status="$status"
                color=1
            fi
            ;;
        Charging) status="󰚥$status" ;;
        "Not charging") status=" " ;;
        Unknown) status="? $status" ;;
        *) exit 1 ;;
    esac
    echo "^C$color^$status$capacity%"
done
'';
  dwmblocksAsync = pkgs.dwmblocks.overrideAttrs(old: let
    configFile = pkgs.writeText "config.def.h" ''
#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
#define DELIMITER "  "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 1

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)             \
    X("", "${batScript}/bin/sb-bat", 1, 10)

#endif  // CONFIG_H
    '';
    in {
    src = pkgs.fetchFromGitHub {
      owner = "UtkarshVerma";
      repo = "dwmblocks-async";
      rev = "main"; # or a commit/tag
      sha256 ="E3Jk+Cpcvo7/ePEdi09jInDB3JqLwN+ZHtutk3nmmhM=";
    };
    buildInputs = [ pkgs.libx11 
      pkgs.pkg-config
      pkgs.xorg.libxcb
      pkgs.xorg.xcbutil
    ];

    postPatch = ''
      cp ${configFile} config.h
    '';
  });
in
{
  environment.systemPackages = with pkgs;[
  	dwmblocksAsync
    batScript
  ];
}
