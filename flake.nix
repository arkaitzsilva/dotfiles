{
  description = "My NixOS dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprnix = {
      url = "github:hyprwm/hyprnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Remove when hyprqt6engine is integrated into hyprnix
    hyprqt6engine = {
      url = "github:hyprwm/hyprqt6engine";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    declarative-flatpak.url = "github:in-a-dil-emma/declarative-flatpak/latest";

    kvantum-themes = {
      url = "github:arkaitzsilva/gtk-themes";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

    icon-themes = {
      url = "github:arkaitzsilva/icon-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    cursor-themes = {
      url = "github:arkaitzsilva/cursor-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs:
    let
      mkLib = nixpkgs:
        nixpkgs.lib.extend
          (self: super: {
            shelf = import ./lib { lib = self; };
          } // inputs.home-manager.lib);

      overlayFiles =
        builtins.attrNames
          (builtins.readDir ./overlays);

      overlays =
        map (name: import (./overlays + "/${name}"))
          overlayFiles;

      addNewHost = hostName:
        with inputs;
          let
            defaults = import ./defaults.nix { inherit hostName; };
          in
            nixpkgs.lib.nixosSystem {
              system = defaults.system;
              modules = [
                { nixpkgs.overlays = overlays; }
                ./modules
                (./. + "/hosts/${hostName}/") # The host specific configuration
              ];
            
            # Pass the variables to other modules
            specialArgs = {
              lib = mkLib inputs.nixpkgs;
              inherit inputs hostName defaults;
            };
          };
  in {
    nixosConfigurations = {
      # USAGE: addNewHost <hostname>
      Alienware13 = addNewHost "Alienware13";
      M11xR3 = addNewHost "M11xR3";
    };
  };
}
