{
  config,
  pkgs,
  lib,
  inputs,
  defaults,
  ...
}:
with lib; with lib.shelf; let
  cfg = config.shelf.desktop.niri;

  niriPkg = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;

  polkit_gnome = pkgs.polkit_gnome.overrideAttrs (old: {
    nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.wrapGAppsHook3 ];

    postFixup = ''
      wrapProgram $out/libexec/polkit-gnome-authentication-agent-1 \
        --set GDK_BACKEND wayland \
        --unset DISPLAY

      mkdir -p $out/bin
      ln -s $out/libexec/polkit-gnome-authentication-agent-1 $out/bin/polkit-gnome-authentication-agent-1
    '';
  });
in {
  options.shelf.desktop.niri = {
    enable = mkBoolOpt false "Whether to enable Niri WM, with desktop addons.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ niriPkg ];

    security.polkit.enable = true;

    services = {
      displayManager.sessionPackages = [ niriPkg ];
      gnome.gnome-keyring.enable = true;
      upower.enable = true;
    };

    systemd.packages = [ niriPkg ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      config.niri = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };

    shelf.home.extraOptions.systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${polkit_gnome}/bin/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    shelf.home.packages = with pkgs; [
      xwayland-satellite
      wl-clipboard
      cliphist
      brightnessctl
      playerctl
    ];

    shelf.desktop.addons = {
      ly = enabled;
      awww = enabled;
      stasis = enabled;
      flatpak = enabled;
      gtk = enabled;
    };

    shelf.cli = {
      packages = enabled;      
      oh-my-posh = enabled;
    };

    shelf.apps = {    
      standalone = {
        packages = enabled;
        foot = enabled;
        mpv = enabled;
        yazi = enabled;
        helix = enabled;
      };
    };

    shelf.home.configFile."niri/config.kdl".source = "${defaults.configFolder}/niri/config.kdl";

    shelf.home.configFile."niri/animations.kdl".source = "${defaults.configFolder}/niri/animations.kdl";
    shelf.home.configFile."niri/device.kdl".source = "${defaults.configFolder}/niri/devices/device_${defaults.hostName}.kdl";
    shelf.home.configFile."niri/keybindings.kdl".source = "${defaults.configFolder}/niri/keybindings.kdl";
    shelf.home.configFile."niri/theme.kdl".source = "${defaults.configFolder}/niri/color-scheme-variants/${defaults.colorSchemeVariant}.kdl";
  };
}
