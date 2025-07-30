{
  config,
  pkgs,
  lib,
  default,
  hostName,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.system.hosts.${hostName};
in {
  options.shelf.system.hosts.${hostName} = {
    variant = mkOpt (lib.types.enum ["light" "dark" "amoled"]) "dark" "Colorscheme variant.";
    type = mkOpt' (lib.types.enum [
      "scheme-content"
      "scheme-expressive"
      "scheme-fidelity"
      "scheme-fruit-salad"
      "scheme-monochrome"
      "scheme-neutral"
      "scheme-rainbow"
      "scheme-tonal-spot"
    ]) "dark";
  };

  config = {};
}
