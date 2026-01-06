{pkgs, host, ...}:
{
  networking = {
    hostName="${host}";
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
