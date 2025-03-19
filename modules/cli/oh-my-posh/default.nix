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

  theme = builtins.fromJSON (builtins.readFile "${default.configFolder}/oh-my-posh/themes/minimal.json");
  colorSchemeVariant = builtins.fromJSON (builtins.readFile "${default.configFolder}/oh-my-posh/color-scheme-variants/${default.colorSchemeVariant}.json");
  mergedConfig = lib.recursiveUpdate theme colorSchemeVariant;

  jsonFormat = pkgs.formats.json { };
in {
  options.shelf.cli.oh-my-posh = {
    enable = mkBoolOpt false "Whether to enable oh-my-posh.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = zshEnabled;
      settings = mergedConfig;
    };
  };
}
