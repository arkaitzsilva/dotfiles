{
  description = "My nixos dotfiles flake";

  outputs = {nixpkgs, ...} @ inputs: let

    default = {
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      stateVersion = "25.05";

      configFolder = ./dotfiles/config;
      # templateFolder = ./dotfiles/templates;

      wallpaperResolution = "1080p";
      colorVariant = "dark";

      system = "x86_64-linux";
      hostName = "Alienware13";
      username = "alienware";
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
      Alienware13 = addNewHost default.hostName;
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
