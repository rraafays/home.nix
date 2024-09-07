{ pkgs, lib, ... }:

let
  USER = "raf";
in
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
      unstable =
        import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz")
          { };
    };
  };

  home-manager.users.${USER} = {
    home = {
      enableNixpkgsReleaseCheck = false;
      packages = with pkgs; [
        adbfs-rootless
        android-tools
        jetbrains.idea-ultimate
        mprocs
        mpv
        typer
        xdg-utils
        soulseekqt
        xdg-user-dirs
        zathura
      ];
      sessionVariables = {
        XDG_DESKTOP_DIR = "$HOME/Desktop";
        XDG_DOWNLOAD_DIR = "$HOME/Downloads";
        XDG_TEMPLATES_DIR = "$HOME/Templates";
        XDG_PUBLICSHARE_DIR = "$HOME/Public";
        XDG_DOCUMENTS_DIR = "$HOME/Documents";
        XDG_MUSIC_DIR = "$HOME/Music";
        XDG_PICUTRES_DIR = "$HOME/Pictures";
        XDG_VIDEOS_DIR = "$HOME/Videos";
      };
      activation.xdg-user-dirs = lib.mkAfter ''
        ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update
      '';
    };
  };
}
