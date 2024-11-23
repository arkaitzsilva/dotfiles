{
  description = "My nixos dotfiles flake";

  outputs = {nixpkgs, ...} @ inputs: let

    default = {
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "25.05";

      configFolder = ./dotfiles/config;
      templateFolder = ./dotfiles/templates;

      wallpaperResolution = "768p";

      system = "x86_64-linux";
      username = "alienware";
      host = "M11xR3";
    };

    mkLib = nixpkgs:
      nixpkgs.lib.extend
      (self: super: {shelf = import ./lib {lib = self;};} // inputs.home-manager.lib);

    addNewHost = hostName:
      with inputs;
        nixpkgs.lib.nixosSystem {
          system = default.system;
          modules = [
            ./modules
            # The host specific configuration
            (./. + "/hosts/${hostName}/")
            {
              environment.systemPackages = [
                matugen.packages.${default.system}.default
              ];
            }
            inputs.matugen.nixosModules.default
          ];
          
          # Pass the variables to other modules
          specialArgs = {
            lib = mkLib inputs.nixpkgs;
            inherit inputs hostName default;
          };
        };
  in {
    nixosConfigurations = {
      # USAGE: addNewHost <hostname>
      M11xR3 = addNewHost default.host;
    };
  };

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

    #ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen";
    swww.url = "github:LGFae/swww";
  };
}
