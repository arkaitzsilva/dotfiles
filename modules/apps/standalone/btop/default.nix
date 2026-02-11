{
  config,
  pkgs,
  lib,
  defaults,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.apps.standalone.btop;
in {
  options.shelf.apps.standalone.btop = {
    enable = mkBoolOpt false "Whether to enable btop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      intel-gpu-tools
      btop
    ];

    # To use btop as non-root user & detect GPU
    security.wrappers.btop = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+ep";
      source = "${pkgs.btop}/bin/btop";
    };

    shelf.home.configFile."btop/themes/theme.theme".source = "${defaults.configFolder}/btop/color-scheme-variants/${defaults.colorSchemeVariant}.theme";
    shelf.home.configFile."btop/btop.conf".source = "${defaults.configFolder}/btop/btop.conf";
  };
}
