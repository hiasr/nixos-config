# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];


  networking.hostName = "thonk";

  networking.wireless = {
    enable = true;
    networks = {
        telenet-3705F = {
            psk = "xAyASeu1cJA5";
        };
        telenet-ap-6908159 = {
            psk = "baYktjvxV7ch";
        };

    };
  };

  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  # For VM
  boot.loader.grub.enable = true;

  # For bare metal 
  # boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.useOSProber = true;
  # 

  programs.zsh.enable = true;
  users.users = {
    rubenh = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      description = "Ruben Hias";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      shell = pkgs.zsh;
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    settings = {
    PermitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    PasswordAuthentication = true;
};
  };

  # Wayland stuff
  security.polkit.enable = true;
  hardware.opengl.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.sessionPackages = [pkgs.sway];
  services.xserver.displayManager.lightdm.enable = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Audio
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
