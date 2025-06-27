{
  config,
  pkgs,
  lib,
  inputs,
  options,
  hostName,
  ...
}:
with lib;
with lib.shelf; let
in {
  imports = lib.shelf.validFiles ./.;
}
