{ pkgs, config, lib, ...} : 
{
    wayland.windowManager.sway = {
        enable = true;
    };
    xdg.configFile."sway".source = lib.mkForce configs/sway;
}
