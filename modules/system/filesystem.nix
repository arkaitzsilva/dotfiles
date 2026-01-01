{
  pkgs,
  ...
}:
{
  system.fsPackages = [ pkgs.bindfs ];
}
