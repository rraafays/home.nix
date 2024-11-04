{ pkgs, lib, ... }:

let
  USER = "raf";
in
{
  home-manager = {
    backupFileExtension = "backup";
    users.${USER} = {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = with pkgs; [
          adbfs-rootless
          android-tools
          ardour
          bandwhich
          brave
          drawio
          google-chrome
          haruna
          jetbrains.idea-ultimate
          kdenlive
          mprocs
          mpv
          nicotine-plus
          quickemu
          transmission-qt
          typer
          xdg-user-dirs
          xdg-utils
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
      xdg.desktopEntries = {
        drawio = {
          name = "Drawio";
          exec = "drawio";
          terminal = false;
          categories = [ "Application" ];
        };
        ardour = {
          name = "Ardour";
          exec = "ardour8";
          terminal = false;
          categories = [ "Application" ];
        };
      };
    };
  };
}
