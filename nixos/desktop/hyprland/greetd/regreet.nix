{ pkgs, ... }: {
  programs.regreet = {
    enable = true;
    #package = regreet-override;
    settings = {
      GTK = {
        # Whether to use the dark theme
        application_prefer_dark_theme = true;

        # Cursor theme name
        #cursor_theme_name = common-attrs.gtk-theme.cursorTheme.name;

        # Font name and size
        font_name = "Cantarell 11";

        # Icon theme name
        #icon_theme_name = common-attrs.gtk-theme.iconTheme.name;

        # GTK theme name
        theme_name = "Colloid-Teal-Dark-Compact";
      };

      commands = {
        # The command used to reboot the system
        reboot = [ "systemctl" "reboot" ];

        # The command used to shut down the system
        poweroff = [ "systemctl" "poweroff" ];
      };

      appearance = {
        # The message that initially displays on startup
        greeting_msg = "¡Hola!";
      };
    };
  };
}