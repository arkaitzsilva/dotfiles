{
  config,
  pkgs,
  lib,
  defaults,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.helix;
in with lib; {
  options.shelf.apps.standalone.helix = {
    enable = mkBoolOpt false "Whether to enable helix editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      helix
    ];
    
    shelf.home.configFile."helix".source = "${defaults.configFolder}/helix";
  };
}
