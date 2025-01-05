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
in
{
  imports = [ ./zellij.nix ./tmux.nix ];

  home.packages = with pkgs; [
    eza
    ripgrep
    wget
    kitty

    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];

  # home.file."Applications/home-manager".source =
  #   let
  #     apps = pkgs.buildEnv {
  #       name = "home-manager-applications";
  #       paths = config.home.packages;
  #       pathsToLink = "/Applications";
  #     };
  #   in
  #   lib.mkIf pkgs.stdenv.targetPlatform.isDarwin { text = "${apps}/Applications"; };
  #
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
          family = "Iosevka Nerd Font";
        };
        terminal.shell = {
          program = "zsh";
          args = [
            "-l"
            "-c"
            "zellij"
            # "tmux attach || tmux new zsh"
          ];
        };
        window = {
          decorations = (if isLinux then "None" else "Buttonless");
          opacity = 0.95;
          option_as_alt = "Both";
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
              chars = "\\u001b[${toString (48 + n)};5u";
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
        ""
        "if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi"
        ""
        """
        zellij_tab_name_update() {
            if [[ -n $ZELLIJ ]]; then
                local current_dir=$PWD
                if [[ $current_dir == $HOME ]]; then
                current_dir=\"~\"
            else
                current_dir=\${current_dir##*/}
            fi
                command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
            fi
        }

        zellij_tab_name_update
        chpwd_functions+=(zellij_tab_name_update)
        """
      ];
      envExtra = lib.concatStringsSep "\n" [
        (
          "PATH="
          + lib.concatStringsSep ":" (
            [
              "${config.home.homeDirectory}/.tfenv/bin"
              "${config.home.homeDirectory}/.local/bin"
              "${config.home.homeDirectory}/.cargo/bin"
              "${config.home.homeDirectory}/go/bin"
              "${config.home.homeDirectory}/.spicetify"
              "$PATH"
            ]
            ++ (
              if pkgs.stdenv.targetPlatform.isDarwin then
                [
                  "/opt/homebrew/bin"
                  "${config.home.homeDirectory}/miniconda/bin"
                ]
              else
                [ ]
            )
          )
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
        cd = "z";
        tf = "terraform";
        nd = "nix develop -c zsh";
        lg = "lazygit";
      } // (if isLinux then { hm = "home-manager --flake .#linux"; } else { hm = "home-manager --flake .#darwin"; });
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
    };
    starship = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  xdg.configFile."nvim/init.lua".enable = false; # Disable default config
  home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home-manager/configs/nvim";
}
