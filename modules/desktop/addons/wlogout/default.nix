{
  config,
  pkgs,
  lib,
  default,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.wlogout;
in {
  options.shelf.desktop.addons.wlogout = with types; {
    enable = mkBoolOpt false "Whether to enable wlogout.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [];

    shelf.home.programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "lock";
          action = "hyprlock";
          text = "Bloquear";
          keybind = "l";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernar";
          keybind = "h";
        }
        {
          label = "logout";
          action = "loginctl terminate-user $USER";
          text = "Cerrar sesión";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Apagar";
          keybind = "s";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspender";
          keybind = "u";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reiniciar";
          keybind = "r";
        }
      ];

      style = ''
        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: rgba(30, 30, 46, 0.9);
        }

        button {
          margin: 5px;
          border-radius: 10px;
          border-color: #cba6f7;
          text-decoration-color: #cdd6f4;
          color: #cdd6f4;
          background-color: #181825;
          border-style: solid;
          border-width: 1px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 64px;
        }

        button:focus, button:active, button:hover {
          /* 20% Overlay 2, 80% mantle */
          background-color: rgb(48, 50, 66);
          outline-style: none;
        }

        #lock {
          background-image: url("/home/${default.username}/.config/wlogout/icons/system-lock-screen.svg");
        }

        #logout {
          background-image: url("/home/${default.username}/.config/wlogout/icons/system-log-out.svg");
        }

        #suspend {
          background-image: url("/home/${default.username}/.config/wlogout/icons/system-suspend.svg");
        }

        #hibernate {
          background-image: url("/home/${default.username}/.config/wlogout/icons/system-suspend-hibernate.svg");
        }

        #shutdown {
          background-image: url("/home/${default.username}/.config/wlogout/icons/system-shutdown.svg");
        }

        #reboot {
          background-image: url("/home/${default.username}/.config/wlogout/icons/system-reboot.svg");
        }
      '';
    };

    #shelf.home.configFile."wlogout/layout".source = "${default.configFolder}/wlogout/layout";
    shelf.home.configFile."wlogout/icons".source = "${default.configFolder}/wlogout/icons";
  };
}
