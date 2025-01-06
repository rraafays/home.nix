{ pkgs, lib, ... }:

let
  USER = "raf";
  EMAIL = "rraf@tuta.io";
in
{
  home-manager = {
    backupFileExtension = "backup";
    users.${USER} = {
      services.mpd = {
        enable = true;
        musicDirectory = "/home/${USER}/Music/";
        extraConfig = ''
          audio_output {
            type "pulse"
            name "Pulseaudio"
            server "127.0.0.1"
          }
        '';
      };
      programs.git = {
        enable = true;
        userName = USER;
        userEmail = EMAIL;
        extraConfig = {
          push = {
            autoSetupRemote = true;
          };
        };
      };
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = with pkgs; [
          adbfs-rootless
          android-tools
          ardour
          bandwhich
          discord
          drawio
          google-chrome
          jetbrains.idea-ultimate
          kdenlive
          librewolf
          mprocs
          mpv
          nicotine-plus
          obs-studio
          picard
          quickemu
          rmpc
          sacad
          songrec
          spotdl
          spotify
          staruml
          transmission_4-qt
          typer
          unstable.kitty
          vscode
          whatsapp-for-linux
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
