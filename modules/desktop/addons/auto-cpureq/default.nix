{
  config,
  lib,
  ...
}:
with lib;
with lib.shelf; let
  cfg = config.shelf.desktop.addons.auto-cpufreq;
in {
  options.shelf.desktop.addons.auto-cpufreq = with types; {
    enable = mkBoolOpt false "Whether to enable auto-cpufreq.";
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq = {
      enable = true;

      settings = {
        general = {
          monitoring = true;
          force_turbo = false;
          use_frequency_scaling = true;
        };

        battery = {
          governor = "schedutil";
          scaling_min_freq = 1000000;
          scaling_max_freq = 2600000;
          energy_performance_preference = "balance_performance";
        };

        charger = {
          governor = "schedutil";
          scaling_min_freq = 1200000;
          scaling_max_freq = 3000000;
          energy_performance_preference = "performance";
        };

        turbo = {
          enabled = true;
        };
      };
    };
  };
}
