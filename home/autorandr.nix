{pkgs, config, ...}:
{
  home.packages = with pkgs; [
    autorandr
    feh
  ];

  programs.autorandr = {
    enable = true;
    hooks.postswitch = {
      set-wallpaper = ''
        ${pkgs.feh}/bin/feh --no-fehbg --bg-fill /etc/nixos/walls/Cloudsday.jpg
      '';
    };
  };
  xsession.initExtra = ''
    autorandr --change &
  '';
}
