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
in {
  options.shelf.apps.gtk.vscode = {
    enable = mkBoolOpt false "Whether to enable vscode.";
  };

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [];

    shelf.home.programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        arcticicestudio.nord-visual-studio-code
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "hypernym-icons";
          publisher = "hypernym-studio";
          version = "2.0.2";
          sha256 = "sha256-BrjujDjxPjZRw9+2DDBsU/45hxdrVgsowvsIyNweDy0=";
        }
      ];
    };    
  };
}
