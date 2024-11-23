{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.oh-my-posh;
in {
  options.shelf.cli.oh-my-posh = {
    enable = mkBoolOpt false "Whether to enable oh-my-posh.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "tokyonight_storm";      
    };
  };
}
