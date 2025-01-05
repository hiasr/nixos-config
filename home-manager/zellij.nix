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
    package = unstable.zellij;
  };
  xdg.configFile."zellij".source = ./configs/zellij;
}
