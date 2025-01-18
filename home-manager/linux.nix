{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    ./wayland.nix
    ./sway.nix
    ./hyprland.nix
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    beeper
    spotify
    google-chrome
    albert
    discord
    udiskie
    bitwarden-cli
    kanshi
    clang
    llvm
    nodejs
    unzip
    obsidian
    vlc
    stremio
    pavucontrol
    unstable.ghostty

    # coding
    (python3.withPackages (ppkgs: [
      ppkgs.i3ipc
      ppkgs.pip
    ]))
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
  programs = {

    firefox = {
      enable = true;
      package = (config.lib.nixGL.wrap pkgs.firefox);
      profiles = {
        default = {
          id = 0;
          name = "Default";
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
          '';
        };
      };
    };

    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}
