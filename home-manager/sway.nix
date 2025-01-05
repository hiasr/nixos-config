{
  pkgs,
  config,
  lib,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
  };

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "main_setup";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080";
          }
          {
            criteria = "DP-2";
            mode = "3840x2160";
            scale = 1.35;
            position = "1920,0";
          }
        ];
      }
      {
        profile.name = "main_setup2";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080";
          }
          {
            criteria = "HDMI-A-1";
            mode = "3840x2160";
            scale = 1.35;
            position = "1920,0";
          }
        ];
      }
      {
        profile.name = "skere_setup";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080";
          }
          {
            criteria = "HDMI-A-2";
            mode = "1680x1050";
            position = "1920,0";
          }
        ];
      }
      {
        profile.name = "snow";
        profile.outputs = [
          {
            criteria = "HDMI-A-2";
            mode = "3840x2160";
            scale = 1.35;
          }
        ];
      }
    ];
  };

  xdg.configFile."sway".source = ./configs/sway;
}
