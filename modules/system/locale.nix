{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.system.locale;
in {
  options.shelf.system.locale = {
    timeZone = mkOpt types.str none "The time zone used for system. (https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)";
  };

  config = {
    time.timeZone = cfg.timeZone;

    i18n = let
      es_ES = "es_ES.UTF-8";
    in {
      defaultLocale = es_ES;
      extraLocaleSettings = {
        LC_ADDRESS = es_ES;
        LC_IDENTIFICATION = es_ES;
        LC_MEASUREMENT = es_ES;
        LC_MONETARY = es_ES;
        LC_NAME = es_ES;
        LC_NUMERIC = es_ES;
        LC_PAPER = es_ES;
        LC_TELEPHONE = es_ES;
        LC_TIME = es_ES;
      };
    };

    console.useXkbConfig = true;

    services.xserver = {
      xkb.layout = "es";
      xkb.variant = "";
    };
  };
}
