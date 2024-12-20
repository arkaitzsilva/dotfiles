{
  pkgs,
  inputs,
  config,
  lib,
  options,
  default,
  hostName,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.matugen;
  #wallpaper = config.shelf.system.hosts.${hostName}.wallpaper or default.wallpaper;
in {
  options.shelf.desktop.addons.matugen = {
    enable = mkBoolOpt false "Whether to enable matugen.";
  };
  
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.matugen.packages.${system}.default
    ];

    programs.matugen = {
      enable = true;
      variant = config.shelf.system.hosts.${hostName}.variant or "dark";
      jsonFormat = "hex";
      type = config.shelf.system.hosts.${hostName}.type or "scheme-tonal-spot";

      #inherit wallpaper;

      templates = {
        "gtk3" = {
          input_path = "${default.templateFolder}/gtk3-colors.css";
          output_path = "~/.config/gtk-3.0/gtk.css";
        };
        "hyprland" = {
          input_path = "${default.templateFolder}/hyprland-colors.conf";
          output_path = "~/.config/hypr/colors.conf";
          #post_hook = "hyprctl reload";
        };
        "kitty" = {
          input_path = "${default.templateFolder}/kitty-colors.conf";
          output_path = "~/.config/kitty/colors.conf";
        };
        "wofi" = {
          input_path = shelf.mergeFiles [ "${default.configFolder}/wofi/style.css" "${default.templateFolder}/wofi-colors.css" ];
          output_path = "~/.config/wofi/style.css";
        };
        "foot" = {
          input_path = shelf.mergeConfigMatugenColors "${default.configFolder}/foot/foot.ini" "${default.templateFolder}/foot-colors.ini";
          output_path = "~/.config/foot/foot.ini";
        };
      };
    };
  };
}
