{
  time.timeZone = "Europe/Madrid";

  i18n = {
    supportedLocales = [ "es_ES.UTF-8/UTF-8" ];
    defaultLocale = "es_ES.UTF-8";
    extraLocaleSettings = {
      LANG = "es_ES.UTF-8";
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
      LC_ALL = "es_ES.UTF-8";
    };
  };
  
  console.useXkbConfig = true;

  services.xserver = {
    xkb.layout = "es";
    xkb.variant = "";
  };
}
