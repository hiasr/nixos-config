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
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    tmux
    eza
    ripgrep

(fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];

  home.file."Applications/home-manager".source =
    let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in
    lib.mkIf pkgs.stdenv.targetPlatform.isDarwin "${apps}/Applications";

  programs = {
    home-manager.enable = true;

    atuin.enable = true;

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
          args = [
            "-l"
            "-c"
            "tmux attach || tmux new zsh"
          ];
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
          bindings = (
            map (n: {
              key = "Key${toString n}";
              mods = "Control";
              chars = "\u001b[${toString (48 + n)};5u";
            }) (lib.range 0 9)
          );
        };
      };
    };

    bat.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    go = {
      enable = true;
      package = unstable.go;
    };




    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = true;
      autocd = true;
      initExtra = lib.concatStringsSep "\n" [
      """if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi"""
        # """if [[ -z $ZELLIJ ]]; then
        #     zellij attach -c
        #     fi
        # """
      ];
      envExtra = lib.concatStringsSep "\n" [
        (
          "PATH="
          +
            lib.concatStringsSep ":" ([
              "${config.home.homeDirectory}/.tfenv/bin"
              "${config.home.homeDirectory}/.local/bin"
              "${config.home.homeDirectory}/.cargo/bin"
              "${config.home.homeDirectory}/go/bin"
              "${config.home.homeDirectory}/.spicetify"
              "$PATH"
            ]
            ++ (if pkgs.stdenv.targetPlatform.isDarwin then [ 
                "/opt/homebrew/bin"
                "${config.home.homeDirectory}/miniconda/bin"
                ] else [ ]))
        )
      ];
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
        lg = "lazygit";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
      plugins = [
        {
          name = "zsh-syntax-highlighting";
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
      userEmail = "ruben.hias@techwolf.ai";

      extraConfig = {
        core = {
          editor = "nvim";
        };
        color = {
          ui = true;
        };
        push = {
          default = "simple";
          autoSetupRemote = true;
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
    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home-manager/configs/nvim";
}