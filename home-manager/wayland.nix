{
  pkgs,
  config,
  lib,
  ...
}:
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

  # Needed for nm-applet to work
  home.packages = with pkgs; [
    networkmanagerapplet
    gnome.adwaita-icon-theme
    gnome-icon-theme
  ];

  xdg.configFile."waybar".source = ./configs/waybar;
}
