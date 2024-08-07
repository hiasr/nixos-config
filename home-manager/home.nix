# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: 
let 
    unstable = import inputs.nixpkgs-unstable {
        system = pkgs.system;
        config.allowUnfree = true;
    };
    catppuccin = inputs.catppuccin;
    nixGLIntel = inputs.nixGL.packages.${pkgs.system}.nixGLIntel;
in
{
  imports = [./tmux.nix ./wayland.nix ./sway.nix ./hyprland.nix catppuccin.homeManagerModules.catppuccin
   (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
      sha256 = "0g5yk54766vrmxz26l3j9qnkjifjis3z2izgpsfnczhw243dmxz9";
    })];

  nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

  nixpkgs = {
    overlays = [
      inputs.fenix.overlays.default
    ];

    config = {
      allowUnfree = true;
    };
  };

    home =  {
      username = "rubenh";
      homeDirectory = if lib.strings.hasInfix "darwin" pkgs.system then "/Users/${config.home.username}" else "/home/${config.home.username}";
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        BROWSER = "firefox";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        NIXOS_OZONE_WL = "1";
      };
    };

  home.packages = with pkgs; [
    tmux
    beeper
    spotify
    google-chrome
    albert
    eza
    discord
    udiskie
    bitwarden-cli
    ripgrep
    kanshi
    clang
    llvm
    nodejs
    unzip

    # coding
    (python3.withPackages (ppkgs: [ppkgs.i3ipc]))

    (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
    rust-analyzer-nightly

    # fonts
    nerdfonts
    iosevka
    todoist
  ];

  fonts.fontconfig.enable = true;

  catppuccin.enable = true;

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
    catppuccin.enable = false;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };


  programs = {
    home-manager.enable = true;

    alacritty = {
        enable = true;
        package = (config.lib.nixGL.wrap pkgs.alacritty);
        settings = {
            env = {
                TERM = "xterm-256color";
            };
            font = {
                size = 13;
            };
            font.normal = {
                family = "Iosevka";
            };
            shell = {
                program = "zsh";
                args = ["-l" "-c" "tmux attach || tmux new zsh"];
            };
            window = {
                decorations = "none";
                opacity = 0.85;
            };
            window.padding = {
                x = 5;
                y = 5;
            };
            keyboard = {
                bindings = (map (n: {key="Key${toString n}"; mods="Control"; chars="\u001b[${toString (48+n)};5u";}) (lib.range 0 9));
            };
        };
    };

    bat = {
        enable = true;
    };

    btop = {
        enable = true;
    };

    direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
    };

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

    zsh = {
        enable = true;
        dotDir = ".config/zsh";
        autosuggestion.enable = true;
        autocd = true;
        initExtra = lib.concatStringsSep "\n" [
            # """if [[ -z $ZELLIJ ]]; then
            #     zellij attach -c
            #     fi
            # """
            ];
        envExtra = lib.concatStringsSep "\n" [
            ("PATH=" + lib.concatStringsSep ":" [
                "${config.home.homeDirectory}/.tfenv/bin:$PATH"
                "${config.home.homeDirectory}/.local/bin"
                "${config.home.homeDirectory}/.cargo/bin"
                "${config.home.homeDirectory}/go/bin"
                "${config.home.homeDirectory}/.spicetify"
                "$PATH"
            ])];
        shellAliases = {
            ls = "eza";
            ll = "eza -l";
            la = "eza -la";
            l = "eza -l";
            cat = "bat";
            less = "bat";
            dc = "docker compose";
            sv = "source venv/bin/activate";
            nr = "sudo nixos-rebuild --flake .#snow";
            hm = "home-manager --flake .#rubenh@thonk";
            cd = "z";
            tf = "terraform";
            nd = "nix develop -c zsh";
        };
        oh-my-zsh = {
            enable = true;
            plugins = ["git"];
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

    yazi = {
        enable = true;
        catppuccin.enable = true;
        package = unstable.yazi;
        enableZshIntegration = true;
        settings = {
            manager = {
                sort_by = "modified";
                sort_reverse = true;
            };
        };
    };

    gh = {
        enable = true;
        package = pkgs.gitAndTools.gh;
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
            column = {
                ui = "auto";
            };
            branch = {
                sort = "-committerdate";
            };
            init = {
                defaultBranch = "main";
            };
            http.postbuffer = "157286400";
        };
        ignores = [
            "venv/"
            "node_modules/"
        ];
    };

    lazygit.enable = true;

    neovim = {
        enable = true;
        package = unstable.neovim-unwrapped;
        defaultEditor = true;
        vimAlias = true;
        catppuccin.enable = false;
    };

    go = {
        enable = true;
        package = unstable.go;
    };

    rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
