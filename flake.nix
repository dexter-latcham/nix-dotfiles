{
  description = "Dexters nix config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };
  outputs = { self, disko, nixpkgs,stylix, ...}@inputs:
  let
      username = "dex";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      testbed = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.disko.nixosModules.disko
          ./hosts/testbed/disko.nix
          stylix.nixosModules.stylix
            ./hosts/testbed
          ];
        specialArgs = {
            host = "testbed";
            inherit self inputs username;
        };
      };
      nixtop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          stylix.nixosModules.stylix
            ./hosts/laptop
          ];
        specialArgs = {
            host = "nixtop";
            inherit self inputs username;
        };
      };
    };
  };
}
