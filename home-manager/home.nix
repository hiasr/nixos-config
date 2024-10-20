# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

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
  catppuccin = inputs.catppuccin;
  nixGLIntel = inputs.nixGL.packages.${pkgs.system}.nixGLIntel;
in
{
  imports = [
    catppuccin.homeManagerModules.catppuccin
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
      sha256 = "01dkfr9wq3ib5hlyq9zq662mp0jl42fw3f6gd2qgdf8l8ia78j7i";
    })
    ./dev.nix
  ]; #++ (if pkgs.stdenv.isDarwin then [] else [./linux.nix]);

  # nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

  nixpkgs = {
    overlays = [ inputs.fenix.overlays.default ];

    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "rubenh";
    homeDirectory =
      if lib.strings.hasInfix "darwin" pkgs.system then
        "/Users/${config.home.username}"
      else
        "/home/${config.home.username}";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  home.packages = with pkgs; [
    nerdfonts
    iosevka
    todoist
  ];

  services.syncthing.enable = true;

  fonts.fontconfig.enable = true;

  catppuccin.enable = true;

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
