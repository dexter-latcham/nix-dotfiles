{ config, lib, pkgs, myConfig,... }:
with pkgs; let
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
      ${coreutils}/bin/mkdir -p $out/share/applications
      ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
inherit (builtins) attrValues;
in
{
  imports = attrValues myConfig.nixosModules;
  nixpkgs.overlays = attrValues myConfig.overlays;
  home-manager.sharedModules = attrValues myConfig.homeModules;
  #environment.systemPackages = attrValues myConfig.packages.${pkgs.stdenv.hostPlatform.system};


  environment.systemPackages = with pkgs; [
    (GPUOffloadApp steam "steam")
    (GPUOffloadApp heroic "com.heroicgameslauncher.hgl")
  ];

  hardware.graphics = {
    enable=true;
  };

  hardware.nvidia = {
    modesetting.enable=true;
    open = false;
    nvidiaSettings = true;
    prime = {
      offload = {
	enable = true;
	enableOffloadCmd=true;
      };
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };
  services.xserver.videoDrivers = ["nvidia"];

nixpkgs.config.permittedInsecurePackages = [
"qtwebengine-5.15.19"
];

  nixpkgs.config.allowUnfree=true;
  security.polkit.enable = true;
      services.pipewire = {
        enable = true;

        alsa = {
          enable = true;
          support32Bit = true;
        };

        pulse.enable = true;
      };

}
