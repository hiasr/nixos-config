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
    };
  };

  # Needed for nm-applet to work
  home.packages = with pkgs; [
    wl-clipboard
    networkmanagerapplet
    adwaita-icon-theme
    gnome-icon-theme
  ];

  xdg.configFile."waybar".source = ./configs/waybar;
}
