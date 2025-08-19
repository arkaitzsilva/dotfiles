{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.browsers.zen-browser;
in {
  options.shelf.apps.browsers.zen-browser = {
    enable = mkBoolOpt false "Whether to enable zen browser.";
  };

   # imports = with inputs; [
      # zen-browser.homeModules.beta
      # or zen-browser.homeModules.twilight
      # or zen-browser.homeModules.twilight-official
   # ];

  config = mkIf cfg.enable {
    shelf.home.packages = with pkgs; [];    

    shelf.home.programs.zen-browser.enable = true;
  };
}
