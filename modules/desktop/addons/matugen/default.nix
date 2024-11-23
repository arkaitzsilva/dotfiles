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
        "GTK3" = {
          input_path = "${default.templateFolder}/gtk.css";
          output_path = "~/.config/gtk-3.0/gtk.css";
        };
        "Hyprland-colors" = {
          input_path = "${default.templateFolder}/hyprland-colors.conf";
          output_path = "~/.config/hypr/colors.conf";
          #post_hook = "hyprctl reload";
        };
      };
    };

    shelf.home.configFile."gtk-3.0/gtk.css".source = "${config.programs.matugen.theme.files}/.config/gtk-3.0/gtk.css";
    shelf.home.configFile."hypr/colors.conf".source = "${config.programs.matugen.theme.files}/.config/hypr/colors.conf";
  };
}
