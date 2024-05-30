{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [ "${home-manager}/nixos" ];

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
      unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };
    };
  };

  home-manager.users.raf = {
    home.stateVersion = "18.09";
    home.enableNixpkgsReleaseCheck = false;
    home.packages = with pkgs; [
      adbfs-rootless
      android-tools
      jetbrains.idea-ultimate
      kitty
      fzf
      jq
      mprocs
      mpv
      newsboat
      openvpn
      playerctl
      speedtest-rs
      typer
      cliphist
      gamescope
      grim
      rofi
      slurp
      wl-clipboard
      xdg-utils
      nur.repos.wolfangaukang.mouseless
      soulseekqt
      transmission
    ];
  };
}
