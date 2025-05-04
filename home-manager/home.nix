# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  isLinux,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
  nixGLIntel = inputs.nixGL.packages.${pkgs.system}.nixGLIntel;
in
{
  imports = [
    # (builtins.fetchurl {
    #   url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
    #   sha256 = "1krclaga358k3swz2n5wbni1b2r7mcxdzr6d7im6b66w3sbpvnb3";
    # })
    ./dev.nix
  ];
  # nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

  nixpkgs = {
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
    todoist
    ente-cli
    nerd-fonts.iosevka
    nerd-fonts.fantasque-sans-mono
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
