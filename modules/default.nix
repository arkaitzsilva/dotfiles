{
  config,
  pkgs,
  lib,
  inputs,
  options,
  default,
  hostName,
  ...
}:
with lib;
with lib.shelf; let
in {
  imports = lib.shelf.validFiles ./.;
}
