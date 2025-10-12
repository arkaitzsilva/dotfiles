{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.gtk.vscode;

  configBase = builtins.fromJSON (builtins.readFile "${defaults.configFolder}/Code/settings.json");

  colorSchemePath = "${defaults.configFolder}/Code/color-scheme-variants/${defaults.colorSchemeVariant}.json";
  colorSchemeVariant = if builtins.pathExists colorSchemePath then builtins.fromJSON (builtins.readFile colorSchemePath) else {};
    
  mergedConfig = lib.recursiveUpdate configBase colorSchemeVariant;
in {
  options.shelf.apps.gtk.vscode = {
    enable = mkBoolOpt false "Whether to enable vscode.";
  };

  config = mkIf cfg.enable {
    shelf.home.programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ] ++ lib.optionals (defaults.colorSchemeVariant == "nord-dark") (
        [
          arcticicestudio.nord-visual-studio-code
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace
        [
          {
            name = "hypernym-icons";
            publisher = "hypernym-studio";
            version = "2.0.2";
            sha256 = "sha256-BrjujDjxPjZRw9+2DDBsU/45hxdrVgsowvsIyNweDy0=";
          }
        ]
      )
      ++ lib.optionals (defaults.colorSchemeVariant == "tokyo-night-storm") (
        [
          enkia.tokyo-night
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace
        [
          {
            name = "hypernym-icons";
            publisher = "hypernym-studio";
            version = "2.0.2";
            sha256 = "sha256-BrjujDjxPjZRw9+2DDBsU/45hxdrVgsowvsIyNweDy0=";
          }
        ]
      )
      ++ lib.optionals (defaults.colorSchemeVariant == "catppuccin-frappe")
        [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
        ];
    };
    

    shelf.home.configFile."Code/User/settings.json".text = builtins.toJSON mergedConfig;
  };
}
