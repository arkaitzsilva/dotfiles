{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.cli.oh-my-posh;
  zshEnabled = config.shelf.cli.zsh.enable || config.shelf.system.defaultShell == pkgs.zsh;

  theme = builtins.fromJSON (builtins.readFile "${defaults.configFolder}/oh-my-posh/config.json");
  
  colorSchemePath = "${defaults.configFolder}/oh-my-posh/color-scheme-variants/${defaults.colorSchemeVariant}.json";
  colorSchemeVariant = if builtins.pathExists colorSchemePath
    then builtins.fromJSON (builtins.readFile colorSchemePath)
    else {};

  mergedConfig = lib.recursiveUpdate theme colorSchemeVariant;
in {
  options.shelf.cli.oh-my-posh = {
    enable = mkBoolOpt false "Whether to enable oh-my-posh.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = zshEnabled;
      # configFile = "/home/alienware/.config/oh-my-posh/config.json";
      settings = mergedConfig;
    };

    # shelf.home.configFile."oh-my-posh/config.json".source = "${defaults.configFolder}/oh-my-posh/config.json";
    # shelf.home.configFile."oh-my-posh/theme.json".source = "${defaults.configFolder}/oh-my-posh/color-scheme-variants/${defaults.colorSchemeVariant}.json";
  };
}
