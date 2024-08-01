{ pkgs, config, lib, ...} : 
{
   programs = {
      eww = {
        enable = true;
        configDir = ./configs/eww;
        package = pkgs.eww-wayland;
      };
    };

    home.file."./.config/waybar".source = config.lib.file.mkOutOfStoreSymlink ./configs/waybar;
}
