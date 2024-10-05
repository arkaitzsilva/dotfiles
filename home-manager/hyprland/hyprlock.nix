{ config, ... }: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = {
        monitor = "";
        path = "$HOME/.local/share/backgrounds/static_alien_1.png";   # supports png, jpg, webp (no animations, though)
        color = "$base";
        blur_passes = 0;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      # LAYOUT
      label = [
        # TIME
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"%H:%M\")</span>\"";
          color = "rgba(216, 222, 233, 1)";
          font_size = 130;
          font_family = "Homenaje";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }
        # DATE
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%A, %d %B\")\"";
          color = "rgba(216, 222, 233, 1)";
          font_size = 30;
          font_family = "Homenaje";
          position = "0, 135";
          halign = "center";
          valign = "center";
        }
        # USER
        {
          monitor = "";
          text = "$DESC";
          color = "rgba(216, 222, 233, 1)";
          font_size = 25;
          font_family = "Homenaje";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      # USER AVATAR
      #image = {
      #  monitor = "";
      #  path = "$XDG_CONFIG_HOME/hypr/hyprlock/face";
      #  border_color = "0x2979ffff";
      #  border_size = 2;
      #  size = 120;
      #  rounding = 10;
      #  rotate = 0;
      #  reload_time = -1;
      #  reload_cmd = "";
      #  position = "0, -20";
      #  halign = "center";
      #  valign = "center";
      #};

      # INPUT FIELD
      input-field = {
        monitor = "";
        size = "180, 40";
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(100, 114, 125, 0.4)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        font_family = "Homenaje";
        placeholder_text = "<span foreground=\"##ffffff99\">🔒 Contraseña</span>";
        hide_input = false;
        position = "0, -225";
        halign = "center";
        valign = "center";
      };
    };  
  };
}