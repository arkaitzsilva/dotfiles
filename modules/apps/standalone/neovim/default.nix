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
  imports = [ inputs.nvf.nixosModules.default ];

  options.shelf.apps.standalone.neovim = {
    enable = mkBoolOpt false "Whether to enable neovim editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          theme = {
            enable = true;
            name = "${defaults.colorSchemeVariant}";
            style = "dark";
          };
        };
      };
    };
    
    #shelf.home.configFile."nvim/init.lua".source = "${defaults.configFolder}/nvim/init.lua";
  };
}
