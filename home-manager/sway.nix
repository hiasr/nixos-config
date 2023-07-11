{ pkgs, config, ...} : 
{
    programs.sway = {
        enable = true;
        extraPackages = with pkgs; [
            swaybg
            swayidle
            swaylock
            waybar
            mako
            slurp
            grim
            kanshi
            swaymsg
            swaynag
            sway
        ];
    }
    xdg.configFile."sway/config".source = .config/sway/config;
}
