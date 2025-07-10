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
  cfg = config.shelf.apps.standalone.neovim;
in with lib; {
  options.shelf.apps.standalone.neovim = {
    enable = mkBoolOpt false "Whether to enable neovim editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    
    shelf.home.configFile."nvim/init.lua".source = "${defaults.configFolder}/nvim/init.lua";
    shelf.home.configFile."nvim/lua/plugins".source = "${defaults.configFolder}/nvim/lua/plugins";
  };
}
