{
  pkgs,
  config,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        "eDP-1,1920x1080,0x0,1"
        "DP-1,3840x2160,1920x0,1.25"
        "HDMI-A-2,3840x2160,0x0,1.25"
        ",preferred,auto,1"
      ];

      exec-once = [
          "waybar" 
          "fix_env_hyprland tmux"
          "hyprpaper"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "master";
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = false;
        };
      };

      decoration = {
        rounding = 5;

        drop_shadow = true;
        shadow_range = 30;
        shadow_render_power = 3;
      };
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.25, 0.9, 0.1, 1.02";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          # "workspaces, 1, 3, default, slidevert"
          # "workspaces, 1, 3, myBezier, slidefadevert"
          "workspaces, 1, 3, myBezier, fade"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true;
        # soon :)
        # orientation = "center";
      };


      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind =
        [
          ## Launch applications
          "$mod, return, exec, alacritty"
          "$mod, F1, exec, hyprshot -m region --clipboard-only"
          "$mod, F2, exec, firefox"

          "$mod, Q, killactive,"
          "$mod SHIFT, M, exit,"
          "$mod SHIFT, F, togglefloating,"
          "$mod, f, fullscreen,"
          "$mod, g, togglegroup,"
          "$mod, bracketleft, changegroupactive, b"
          "$mod, bracketright, changegroupactive, f"
          "$mod, space, exec, rofi -show drun --show-icons"
          "$mod, p, pin, active"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"

          # Scroll through existing workspaces with mod + scroll
          "bind = $mod, mouse_down, workspace, e+1"
          "bind = $mod, mouse_up, workspace, e-1"
        ]
        ++ map (n: "$mod SHIFT, ${toString n}, movetoworkspace, ${toString (if n == 0 then 10 else n)}") [
          1
          2
          3
          4
          5
          6
          7
          8
          9
          0
        ]
        ++ map (n: "$mod, ${toString n}, workspace, ${toString (if n == 0 then 10 else n)}") [
          1
          2
          3
          4
          5
          6
          7
          8
          9
          0
        ];

      binde = [
        "$mod SHIFT, h, moveactive, -20 0"
        "$mod SHIFT, l, moveactive, 20 0"
        "$mod SHIFT, k, moveactive, 0 -20"
        "$mod SHIFT, j, moveactive, 0 20"

        "$mod CTRL, l, resizeactive, 30 0"
        "$mod CTRL, h, resizeactive, -30 0"
        "$mod CTRL, k, resizeactive, 0 -10"
        "$mod CTRL, j, resizeactive, 0 10"
      ];

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/.config/sway/backgrounds/purple_lake.jpg" ];
      wallpaper = [ ",~/.config/sway/backgrounds/purple_lake.jpg" ];
    };
  };

  home.packages = with pkgs; [
    hyprshot
    (writeShellScriptBin "fix_env_hyprland" ''
       #!/usr/bin/env bash
      set -e

      [[ -n $HYPRLAND_DEBUG_CONF ]] && exit 0
      USAGE="\
      Import environment variables 

      Usage: $0 <command>

      Commands:
         tmux         import to tmux server
         system       import to systemd and dbus user session
         help         print this help
      "

      _envs=(
      	# display
      	WAYLAND_DISPLAY
      	DISPLAY
      	# xdg
      	USERNAME
      	XDG_BACKEND
      	XDG_CURRENT_DESKTOP
      	XDG_SESSION_TYPE
      	XDG_SESSION_ID
      	XDG_SESSION_CLASS
      	XDG_SESSION_DESKTOP
      	XDG_SEAT
      	XDG_VTNR
      	# hyprland
      	HYPRLAND_CMD
      	HYPRLAND_INSTANCE_SIGNATURE
      	# sway
      	SWAYSOCK
      	# misc
      	XCURSOR_SIZE
      	# toolkit
      	_JAVA_AWT_WM_NONREPARENTING
      	QT_QPA_PLATFORM
      	QT_WAYLAND_DISABLE_WINDOWDECORATION
      	GRIM_DEFAULT_DIR
      	# ssh
      	SSH_AUTH_SOCK
      )

      case "$1" in
      system)
      	dbus-update-activation-environment --systemd "''${_envs[@]}"
      	;;
      tmux)
      	for v in "''${_envs[@]}"; do
      		if [[ -n ''${!v} ]]; then
      			tmux setenv -g "$v" "''${!v}"
      		fi
      	done
      	;;
      help)
      	echo -n "$USAGE"
      	exit 0
      	;;
      *)
      	echo "operation reuqired"
      	echo "use \"$0 help\" to see usage help"
      	exit 1
      	;;
      esac
    '')
  ];
}
