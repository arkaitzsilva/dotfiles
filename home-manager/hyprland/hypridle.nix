{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";       # avoid starting multiple hyprlock instances.
        after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150;                               # 2.5min.
          on-timeout = "brightnessctl -s set 1";       # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";              # monitor backlight restore.
        }
        {
          timeout = 300;                               # 5 minutes
          on-timeout = "hyprlock";                     # command to run when timeout has passed
        }
        {
          timeout = 600;                               # 10 minutes
          on-timeout = "systemctl suspend";            # command to run when timeout has passed
        }
      ];
    };
  };
}