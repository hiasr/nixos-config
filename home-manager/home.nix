# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: 

let 
    unstable = import inputs.nixpkgs-unstable {
        system = pkgs.system;
        config.allowUnfree = true;
    };
in
{
  # You can import other home-manager modules here
  imports = [
    ./sway.nix
    # ./tmux.nix
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home =  {
    username = "rubenh";
    homeDirectory = "/home/${config.home.username}";
    sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        BROWSER = "firefox";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/:/run/opengl-driver/lib/";
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    unstable.thunderbird-wayland
    vscode
    discord
    spotify
    docker
    nodejs
    nil
    gcc
    ulauncher
    unstable.obsidian
    gpick

    # fonts
    nerdfonts
    iosevka
  ];

  fonts.fontconfig.enable = true;



programs = {
    home-manager.enable = true;

    alacritty = {
        enable = true;
    };

    bat = {
        enable = true;
        config = {
            theme = "base16-256";
        };
    };

    btop = {
        enable = true;
    };

    direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
    };

    eww = {
        enable = true;
        configDir = ./configs/eww;
    };

    exa = {
        enable = true;
    };

    zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableAutosuggestions = true;
        autocd = true;
        envExtra = lib.concatStringsSep "\n" [
            "AWS_PROFILE=dev-2"
            "_JAVA_AWT_WM_NONREPARENTING=1"
            "SHELL=/usr/bin/zsh"
            ("PATH=" + lib.concatStringsSep ":" [
                "${config.home.homeDirectory}/.local/bin"
                "${config.home.homeDirectory}/.cargo/bin"
                "${config.home.homeDirectory}/go/bin"
                "$PATH"
            ])];
        shellAliases = {
            ls = "exa";
            ll = "exa -l";
            la = "exa -la";
            l = "exa -l";
            cat = "bat";
            less = "bat";
            dc = "docker-compose";
            sv = "source venv/bin/activate";
            nr = "sudo nixos-rebuild --flake .#thonk";
            hm = "home-manager --flake .#rubenh@thonk";
            cd = "z";
        };
        oh-my-zsh = {
            enable = true;
            plugins = ["git" "nvm"];
        };
        plugins = [
            {
                name= "zsh-syntax-highlighting";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
                    repo = "zsh-syntax-highlighting";
                    rev = "1386f12";
                    sha256 = "iKx7lsQCoSAbpANYFkNVCZlTFdwOEI34rx/h1rnraSg=";
                };
            }
        ];
    };

    firefox = {
        enable = true;
        package = unstable.firefox-wayland;
    };

    gh = {
        enable = true;
    };

    git = {
        enable = true;
        userName = "Ruben Hias";
        userEmail = "ruben.hias@gmail.com";
        
        extraConfig= {
            core = {
                editor = "nvim";
            };
            color = {
                ui = true;
            };
            push = {
                default = "simple";
            };
            pull = {
                rebase = "true";
                ff = "only";
            };
            init = {
                defaultBranch = "main";
            };
        };
        ignores = [
            "venv/"
            "node_modules/"
        ];
    };

    neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
    };

    go = {
        enable = true;
    };


    starship = {
        enable = true;
    };

    zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

  };


  home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home-manager/configs/nvim";
  home.file."./.config/alacritty".source = config.lib.file.mkOutOfStoreSymlink ./configs/alacritty;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
