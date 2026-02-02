{
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.flatpak;
in {
  options.shelf.desktop.addons.flatpak = {
    enable = mkBoolOpt false "Whether to enable flatpak.";
  };

  config = mkIf cfg.enable {
    # Flatpak
    shelf.home.sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };

    services.flatpak.enable = true;

    # Declarative Flatpak
    shelf.home.extraImports = [
      inputs.declarative-flatpak.homeModules.default
    ];

    shelf.home.services.flatpak = {
      enable = true;
      remotes = {
        flathub = "https://flathub.org/repo/flathub.flatpakrepo";
      };
      packages = [
        "flathub:app/com.brave.Browser/x86_64/stable"
        "flathub:app/org.mozilla.firefox/x86_64/stable"
        "flathub:app/org.torproject.torbrowser-launcher/x86_64/stable"
        "flathub:app/app.zen_browser.zen/x86_64/stable"
        "flathub:app/dev.zed.Zed/x86_64/stable"
        "flathub:app/org.deluge_torrent.deluge/x86_64/stable"
        "flathub:app/org.inkscape.Inkscape/x86_64/stable"
        "flathub:app/org.gimp.GIMP/x86_64/stable"
        "flathub:app/com.obsproject.Studio/x86_64/stable"
      ];
      overrides = {
        "app.zen_browser.zen" = {
          Environment = {
            __NV_PRIME_RENDER_OFFLOAD = 1;
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          };
        };
        "dev.zed.Zed" = {
          Environment = {
            __NV_PRIME_RENDER_OFFLOAD = 1;
            __VK_LAYER_NV_optimus = "NVIDIA_only";
          };
        };
        "org.deluge_torrent.deluge" = {
          Context = {
            filesystems = [
              "~/Torrent"
            ];
          };
        };
      };
    };
  };
}
