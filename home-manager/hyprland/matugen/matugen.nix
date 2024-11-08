{inputs, config, ...}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];

  programs.matugen = {
    enable = true;
    variant = "dark";
    jsonFormat = "hex";

    templates = {
      GTK3 = {
        input_path = "./templates/gtk-colors.css";
        output_path = "~/.config/gtk-3.0/gtk.css";
      };
    };
  };

  # home.configFile."<path>".source = "${config.programs.matugen.theme.files}/<template_output_path>";
  home.file."${config.xdg.configHome}/gtk-3.0/gtk.css".source = "${config.programs.matugen.theme.files}/.config/gtk-3.0/gtk.css";
}