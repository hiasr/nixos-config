{
  inputs,
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
  programs.zellij = {
    enable = true;
  };
  xdg.configFile."zellij".source = ./configs/zellij;
}
