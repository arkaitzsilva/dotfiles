{ pkgs, ... }: {
  imports = [
    ../home-manager/zsh.nix
    ../home-manager/dconf.nix
    ../home-manager/git.nix
    ../home-manager/packages.nix
    ../home-manager/hyprland.nix    
  ];

  home = {
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXOS_OZONE_WL = "1";
      
      AGS_BUNDLER = "esbuild";
      
      SWWW_TRANSITION = "none";

      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
