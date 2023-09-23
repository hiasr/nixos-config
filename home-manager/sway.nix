{ pkgs, config, lib, ...} : 
{
    home.packages = with pkgs; [
        swaylock-effects
        swayidle
        swaybg
        waybar
    ];

    programs = {
      eww = {
        enable = true;
        configDir = ./configs/eww;
      };
      firefox.enable = true;
    };
        


    wayland.windowManager.sway = {
        enable = true;
    };


    services.kanshi = {
        enable = true;
        profiles = {
            main_setup = {
                outputs = [
                    {
                        criteria = "eDP-1";
                        mode = "1920x1080";
                    }
                    {
                        criteria = "DP-1";
                        mode = "3840x2160";
                        scale = 1.35;
                        position = "1920,0";
                    }
                ];
            };
            skere_setup = {
                outputs = [
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
            };
        };
    };

    xdg.configFile."sway".source = ./configs/sway;
    home.file."./.config/waybar".source = config.lib.file.mkOutOfStoreSymlink ./configs/waybar;
}
