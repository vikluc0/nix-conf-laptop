{
  description = "Nixos flake";

  outputs = {...}: let
    pins = import ./.tack;
    inherit
      (pins)
      nixpkgs
      nixpkgs-unstable
      home-manager
      plasma-manager
      nix-flatpak
      nixos-splash-plasma6
      serpantinum
      nordvpn
      nvf
      bedrock-on-linux
      ;
  in {
    nixosConfigurations.VirusLaptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixos-splash-plasma6;
        inherit bedrock-on-linux;
        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        ./configuration.nix
        nix-flatpak.nixosModules.nix-flatpak
        home-manager.nixosModules.home-manager
        serpantinum.nixosModules.default
        nordvpn.nixosModules.nordvpn
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.vikluc0 = {
              imports = [
                ./home.nix
                plasma-manager.homeModules.plasma-manager
                nvf.homeModules.default
              ];
            };
            backupFileExtension = "hm-backup";
            extraSpecialArgs = {
              inherit nixos-splash-plasma6;
              inherit serpantinum;
              pkgs-unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          };
        }
      ];
    };
  };
}
