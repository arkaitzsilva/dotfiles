{
  config,
  pkgs,
  lib,
  ...
}:
with lib.shelf; {
  imports = validFiles ./.;
}
