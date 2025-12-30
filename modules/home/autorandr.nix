{pkgs, config, ...}:
{
  home.packages = with pkgs; [
    autorandr
    feh
  ];

  programs.autorandr = {
    enable = true;
  };
  xsession.initExtra = ''
    autorandr --change
  '';
}
