let
  name = "arkaitzsilva";
in {
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = name;
      push.autoSetupRemote = true;
    };
    userEmail = "arkaitz.develop@gmail.com";
    userName = name;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  
  services.ssh-agent.enable = true;
}