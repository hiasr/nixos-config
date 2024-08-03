{ pkgs, config, lib, ...} : 
{
   programs = {
      eww = {
        enable = true;
        configDir = ./configs/eww;
      };

      waybar = {
        enable = true;
        catppuccin.enable = false;
      };
    };

    home.file."./.config/waybar".source = config.lib.file.mkOutOfStoreSymlink ./configs/waybar;
}
