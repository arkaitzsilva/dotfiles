{ pkgs, inputs, ...}: let
  screenshot = import ../scripts/screenshot.nix pkgs;
in {
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      inputs.hyprfocus.packages.${pkgs.system}.hyprfocus
    ];

    settings = {
      debug = {
        disable_logs = false;
      };

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = [
        ",preferred,auto,1"
      ];

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      "$mainMod" = "SUPER";
      "$terminal" = "foot";
      "$menu" = "wofi --show drun";

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:
      exec-once = [
        "swww-daemon -f xrgb & swww img $HOME/.local/share/backgrounds/animated_alien_1_768p.gif"
        "ags -b hypr"
        "hyprctl setcursor Luv-Dark 24"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # See https://wiki.hyprland.org/Configuring/Environment-variables/
      env = [
        "NIXOS_OZONE_WL,1"
        "AGS_BUNDLER,esbuild"        
        "WWW_TRANSITION,none"
        "XDG_CONFIG_HOME,$HOME/.config"
      ];

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 2;
        gaps_out = 4;

        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(4dd0e1ee)"; # "rgba(4dd0e1ee) rgba(aed581ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          
          vibrancy = 0.1696;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 4, myBezier, slide"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, myBezier, slide"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "es";
        kb_variant = "";
        follow_mouse = 1;
        touchpad.natural_scroll = false;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = false;
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, R, exec, $menu"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, next, workspace, +1"
        "$mainMod, prior, workspace, -1"

        "$mainMod ALT, next, movetoworkspace, +1"
        "$mainMod ALT, prior, movetoworkspace, -1"

        "$mainMod ALT, left, movewindow, l"
        "$mainMod ALT, right, movewindow, r"
        "$mainMod ALT, up, movewindow, u"
        "$mainMod ALT, down, movewindow, d"

        "$mainMod, M, fullscreen"

        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioNext, exec, playerctl next"

        "$mainMod CONTROL, L, exec, hyprlock"
        "$mainMod CONTROL, P, exec, systemctl poweroff"
        "$mainMod CONTROL, Q, exec, loginctl terminate-user $USER"
        "$mainMod CONTROL, R, exec, systemctl reboot"
        "$mainMod CONTROL, S, exec, systemctl suspend"

        "CTRL SHIFT, R, exec, ags -b hypr quit; ags -b hypr > /tmp/ags.log 2>&1"

        "$mainMod, SPACE, animatefocused"

        ",Print, exec, ${screenshot}"
        "SHIFT, Print, exec, ${screenshot} --full"
      ];

      binde = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      windowrulev2  = [
        "float,regex,class:^(xdg-desktop-portal-gtk)$"
        "size 800 600,regex,class:^(xdg-desktop-portal-gtk)$"
        "suppressevent maximize, class:.*"
      ];

      layerrule = [
        "noanim,^bar[0-9]+"
        #"blur,^bar[0-9]+"
      ];

      plugin = {
        hyprfocus = {
          enabled = "yes";
          animate_floating = "no";
          animate_workspacechange = "no";
          focus_animation = "shrink";

          bezier = [
            "bezIn, 0.5, 0.0, 1.0, 0.5"
            "bezOut, 0.0, 0.5, 0.5, 1.0"
            "overshot, 0.05, 0.9, 0.1, 1.05"
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
            "realsmooth, 0.28, 0.29, 0.69, 1.08"
          ];

          flash = {
            flash_opacity = 0.8;
            in_bezier = "realsmooth";
            in_speed = 0.5;
            out_bezier = "realsmooth";
            out_speed = 3;
          };

          shrink = {
            shrink_percentage = 0.98;
            in_bezier = "realsmooth";
            in_speed = 1;
            out_bezier = "realsmooth";
            out_speed = 2;
          };
        };
      };      
    };
  };
}
