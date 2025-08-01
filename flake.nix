{
  description = "My NixOS dotfiles flake";

  outputs = {nixpkgs, ...} @ inputs: let

    mkLib = nixpkgs:
      nixpkgs.lib.extend
        (self: super: {shelf = import ./lib {lib = self;};} // inputs.home-manager.lib);

    addNewHost = hostName:
      with inputs;
        let
          defaults = import ./defaults.nix { inherit hostName; };
        in
          nixpkgs.lib.nixosSystem {
            system = defaults.system;
            modules = [
              ./modules
              # The host specific configuration
              (./. + "/hosts/${hostName}/")
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
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
