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
      git
      unzip
      gcc
      ripgrep
      fd
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    
    shelf.home.configFile."nvim/lua".source = "${defaults.configFolder}/nvim/lua";
    shelf.home.configFile."nvim/init.lua".source = "${defaults.configFolder}/nvim/init.lua";
    #shelf.home.configFile."nvim/colors.vim".source = "${defaults.configFolder}/nvim/color-scheme-variants/${defaults.colorSchemeVariant}.vim";
  };
}
