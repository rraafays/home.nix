{ pkgs, lib, ... }:

let
  USER = "raf";

  inherit (pkgs) stdenv;
  inherit (lib) mkIf;
in
{
  home-manager = {
    backupFileExtension = "backup";
    users.${USER} = {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages =
          with pkgs;
          [
            adbfs-rootless
            android-tools
            bandwhich
            devenv
            discord
            drawio
            feh
            google-chrome
            hyperfine
            mprocs
            mpv
            mus
            nicotine-plus
            sacad
            spotdl
            sptlrx
            substudy
            unstable.kitty
            yt-dlp-light
            zathura
          ]
          ++ (
            if pkgs.stdenv.isDarwin then
              [
              ]
            else
              [
                ardour
                haruna
                kdePackages.kdenlive
                libreoffice
                librewolf
                mpc
                obs-studio
                okteta
                picard
                protonup-qt
                qpwgraph
                quickemu
                rmpc
                sonata
                songrec
                spotify
                staruml
                subtitlecomposer
                systemdgenie
                transmission_4-qt
                xdg-user-dirs
                xdg-utils
              ]
          );

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
      xdg.desktopEntries = mkIf stdenv.isLinux {
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
