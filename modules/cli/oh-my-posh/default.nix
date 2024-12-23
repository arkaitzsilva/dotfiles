{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.oh-my-posh;
  zshEnabled = config.shelf.cli.zsh.enable || config.shelf.system.defaultShell == pkgs.zsh;
in {
  options.shelf.cli.oh-my-posh = {
    enable = mkBoolOpt false "Whether to enable oh-my-posh.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = zshEnabled;
      settings = builtins.fromJSON (builtins.readFile "${default.configFolder}/oh-my-posh/config.json");
    };
  };
}
