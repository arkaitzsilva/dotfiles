{
  programs.wofi = {
    enable = true;
    
    settings = {
      width = 500;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Buscar...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 32;
      gtk_dark = true;
    };

    style = ''
      window {
        border-radius: 10px;
        border: 1px solid @borders;
      }

      #input {
        border-radius: 5px;
        margin: 10px;
      }

      #inner-box {
        margin: 0 10px 10px 10px;  
      }

      #entry {
        background-color: #3C3C3C;
        margin: 4px;
        border: none;
        border-radius: 4px;
      }

      #entry:selected {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
        outline: none;
      }

      image {
        margin: 5px;
      }
    '';
  };
}