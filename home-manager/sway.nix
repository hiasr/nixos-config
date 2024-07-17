{ pkgs, config, lib, ...} : 
{
    programs = {
      eww = {
        enable = true;
        configDir = ./configs/eww;
        package = pkgs.eww-wayland;
      };
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
                        criteria = "DP-2";
                        mode = "3840x2160";
                        scale = 1.35;
                        position = "1920,0";
                    }
                ];
            };
            main_setup2 = {
                outputs = [
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
            snow = {
                outputs = [
                    {
                        criteria = "HDMI-A-2";
                        mode="3840x2160";
                        scale = 1.35;
                    }
                ];
            };
        };
    };

    xdg.configFile."sway".source = ./configs/sway;
    home.file."./.config/waybar".source = config.lib.file.mkOutOfStoreSymlink ./configs/waybar;
}
