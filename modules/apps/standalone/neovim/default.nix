{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.neovim;
in {
  options.shelf.apps.standalone.neovim = {
    enable = mkBoolOpt false "Whether to enable neovim editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [

    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    # shelf.home.programs.nvf = {
    #   enable = true;
    #   vim = {
    #     theme = {
    #       enable = true;
    #       name = "nord";
    #       style = "dark";
    #     };
    #   };
    # };
    
    #shelf.home.configFile."nvim/init.lua".source = "${defaults.configFolder}/nvim/init.lua";
  };
}
