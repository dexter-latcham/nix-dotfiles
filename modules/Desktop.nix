{ pkgs, config, lib, ... }:let
  dwmblocksAsync = pkgs.stdenv.mkDerivation {
    pname = "dwmblocks";
    version = "1";

    src = pkgs.fetchFromGitHub {
      owner = "UtkarshVerma";
      repo = "dwmblocks-async";
      rev = "main"; # or a commit/tag
      hash = lib.fakeSha256; # leave blank, rebuild and fill
    };

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.libX11 pkgs.pkg-config ]
      ++ builtins.attrValues { inherit (pkgs.xorg) libxcb xcbutil; };

    makeFlags = [ "PREFIX=$(out)" ];

    meta.mainProgram = "dwmblocks";
  };
  in
{
  config = {
    hardware.bluetooth.enable = true;
    hardware.graphics.enable32Bit = true;

    programs = {
      steam.enable = true;
      zsh.enable = true;
      cdemu.enable = true;
      gnupg.agent.enable=true;
      thunar.enable = true;
    };


    console.keyMap="uk";

    services = {
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };

      displayManager.ly.enable=true;

      xserver = {
        enable=true;
        autoRepeatDelay=200;
        autoRepeatInterval=35;
        windowManager.qtile.enable=true;
        windowManager.dwm.enable=true;
        xkb = {
          layout="gb";
          variant="";
        };
      };

      picom = {
        enable=true;
        backend="glx";
        vSync = true;
      };

      gnome.gnome-keyring.enable = true;
      upower.enable = true;
    };
    environment.systemPackages = with pkgs; [
      libxinerama
      xclip
      dwmblocks
      tree-sitter
      stremio
        vim wget neovim fontconfig
        xorg.xinit xorg.xrdb xorg.xsetroot xorg.xev
        gnumake
        xorg.libX11.dev
	github-cli
        xorg.libXft
        xorg.libXinerama
        xorg.libxcb
        gtk3 gtk4 xdg-desktop-portal-gtk
        alacritty
        pulsemixer
        git
        gnumake
	librewolf
        gcc
	spotify
        freetype
        libx11
        libxft
        autorandr
        dmenu
        vesktop
    signal-desktop-bin
      qbittorrent
      texliveFull
      sqlitebrowser
      qdiskinfo
      vlc
      picard
      pulseaudio
      pavucontrol
      libnotify
	lunarvim
google-chrome
    feh
    dunst
    unzip
    arandr
    st
    ];
  };

}
