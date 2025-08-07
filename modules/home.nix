{
  inputs,
  config,
  lib,
  options,
  defaults,
  ...
}:
with lib; let
  cfg = config.shelf.home;
in {
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.shelf.home = with types; {
    file = mkOption {
      type = types.attrs;
      description = ''
        A set of files to be managed by home-manager's <option>home.file</option>.
      '';
    };
    configFile = mkOption {
      type = types.attrs;
      description = ''
        A set of files to be managed by home-manager's <option>xdg.configFile</option>.
      '';
    };
    dataFile = mkOption {
      type = types.attrs;
      description = ''
        A set of files to be managed by home-manager's <option>xdg.dataFile</option>.
      '';
    };
    extraOptions = mkOption {
      type = types.attrs;
      description = ''
        Options to pass directly to home-manager.
      '';
    };
    programs = mkOption {
      type = types.attrs;
      description = ''
        Options to pass directly to home-manager.
      '';
    };
    services = mkOption {
      type = types.attrs;
      description = ''
        Options to pass directly to home-manager.
      '';
    };
    packages = mkOption {
      type = types.attrs;
      description = ''
        Options to pass directly to home-manager.
      '';
    };
  };

  config = {
    shelf.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.shelf.home.file;
      home.packages = mkAliasDefinitions options.shelf.home.packages;
      programs = mkAliasDefinitions options.shelf.home.programs;
      services = mkAliasDefinitions options.shelf.home.services;
      xdg.enable = true;
      xdg.dataFile = mkAliasDefinitions options.shelf.home.dataFile;
      xdg.configFile = mkAliasDefinitions options.shelf.home.configFile;
    };

    home-manager = {
      backupFileExtension = "backup";
      useUserPackages = true;

      users.${defaults.username} = {config, ...}:
        mkMerge [
          (mkAliasDefinitions options.shelf.home.extraOptions)
        ];
    };

    shelf.home.programs.home-manager.enable = true;
  };
}
