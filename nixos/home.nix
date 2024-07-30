{ pkgs, ... }: {
  home = {
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
