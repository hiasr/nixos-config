# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
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

  home = rec {
    username = "rubenh";
    homeDirectory = "/home/${username}";
    sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        BROWSER = "firefox";
        _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    thunderbird
    tmux
    vscode
    waybar
  ];

programs = {
    home-manager.enable = true;

    alacritty = {
        enable = true;
    };

    bat = {
        enable = true;
        highlight = true;
        config = {
            theme = "base16-256";
        };
    };

    btop = {
        enable = true;
    };

    eww = {
        enable = true;
        configDir = "./configs/eww";
    };

    exa = {
        enable = true;
        enableAliases = true;
    };

    fish = {
        enable = true;

        shellAliases = {
            ls = "exa";
            ll = "exa -l";
            la = "exa -la";
            l = "exa -l";
            cat = "bat";
            less = "bat";
            sv = "source venv/bin/activate";
        };
    };

    firefox = {
        enable = true;

    }

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

  };

  services = {
    kanshi = {
        enable = true;
        profiles = {
            main_setup = {
                outputs = {
                    eDP1 = {
                        mode = "1920x1080";
                        scale = 1;
                    };
                    DP1 = {
                        mode = "3840x2160";
                        scale = 1.35;
                        position = "1920,0";
                    };
                };
            };
            skere_setup = {
                outputs = {
                    eDP1 = {
                        mode = "1920x1080";
                        scale = 1;
                    };
                    HDMI-A-2 = {
                        mode = "1680x1050";
                        position = "1920,0";
                    };
                };
            };
        };

    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}