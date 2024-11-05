{ config, ... }: 
let 
  backgroundDir = ./backgrounds/768p;
  scriptDir = ./scripts;

  backgrounds = builtins.readDir backgroundDir;
  scripts = builtins.readDir scriptDir;
in {
  home.file."${config.xdg.dataHome}/backgrounds/".source = backgroundDir;
  home.file."${config.xdg.configHome}/hypr/scripts/".source = scriptDir;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Escritorio";
    documents = "${config.home.homeDirectory}/Documentos";
    download = "${config.home.homeDirectory}/Descargas";
    music = "${config.home.homeDirectory}/Música";
    pictures = "${config.home.homeDirectory}/Imágenes";
    publicShare = "${config.home.homeDirectory}/Público";
    templates = "${config.home.homeDirectory}/Plantillas";
    videos = "${config.home.homeDirectory}/Vídeos";
  };
}
