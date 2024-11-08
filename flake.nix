{
  description = "Configurations of Arkaitz";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprfocus = {
      url = "github:pyt0xic/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };

    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen";
    swww.url = "github:LGFae/swww";
  };

  outputs = inputs @ {
    self, 
    home-manager,
    nixpkgs, 
    ... 
  }: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./nixos/nixos.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
