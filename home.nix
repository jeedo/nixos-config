{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gedes";
  home.homeDirectory = "/home/gedes";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  #vim
  programs.vim.enable = true;
  programs.vim.settings = {
    shiftwidth = 2;
    expandtab = true;
    copyindent = true;
  };
  programs.vim.extraConfig = ''
    nmap ¤ $
  '';

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gedes/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vi";
  };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ll = "ls -l";
  };

  # Hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,auto";

    "$terminal" = "kitty";
    "$fileManager" = "dolplhin";
    "$menu" = "wofi --show drun";

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 20;

      border_size = 2;

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false;

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;

      layout = "dwindle";
    };
    decoration = {
      rounding = 10;

      # Change transparency of focused and unfocused windows
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur = {
        enabled = true;
        size = 3;
        passes = 1;

        vibrancy = 0.1696;
      };
    };
    master = {
      new_status = "master";
    };

    input = {
      kb_layout = "se";
    };

    "$mainMod" = "SUPER";
    bind = [
      "$mainMod, Q, exec, $terminal           "
      "$mainMod, C, killactive,               "
      "$mainMod, M, exit,                     "
      "$mainMod, E, exec, $fileManager        "
      "$mainMod, V, togglefloating,           "
      "$mainMod, space, exec, $menu           "
      "$mainMod, P, pseudo, # dwindle         "
      "$mainMod, J, togglesplit, # dwindle    "
                                              
      # Move focus with mainMod + arrow keys 
      "$mainMod, left, movefocus, l           "
      "$mainMod, right, movefocus, r          "
      "$mainMod, up, movefocus, u             "
      "$mainMod, down, movefocus, d           "
                                              
      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1              "
      "$mainMod, 2, workspace, 2              "
      "$mainMod, 3, workspace, 3              "
      "$mainMod, 4, workspace, 4              "
      "$mainMod, 5, workspace, 5              "
      "$mainMod, 6, workspace, 6              "
      "$mainMod, 7, workspace, 7              "
      "$mainMod, 8, workspace, 8              "
      "$mainMod, 9, workspace, 9              "
      "$mainMod, 0, workspace, 10             "
                                              
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1  "
      "$mainMod SHIFT, 2, movetoworkspace, 2  "
      "$mainMod SHIFT, 3, movetoworkspace, 3  "
      "$mainMod SHIFT, 4, movetoworkspace, 4  "
      "$mainMod SHIFT, 5, movetoworkspace, 5  "
      "$mainMod SHIFT, 6, movetoworkspace, 6  "
      "$mainMod SHIFT, 7, movetoworkspace, 7  "
      "$mainMod SHIFT, 8, movetoworkspace, 8  "
      "$mainMod SHIFT, 9, movetoworkspace, 9  "
      "$mainMod SHIFT, 0, movetoworkspace, 10 "
    ];

    windowrulev2 = [
      # Ignore maximize requests from apps. You'll probably like this.
      "suppressevent maximize, class:.*"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };

  #waybar settings
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "network" "cpu" "clock" "custom/power" ];
        "hyprland/workspaces" = {
          disable.scroll = true;
        };
        clock = {
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        network = {
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected = "Disconnected ⚠";
        };
        "custom/power" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
        };
      };
    };
  };

  #wlogout config
  programs.wlogout.enable = true;
  programs.wlogout.layout = 
    [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }

    ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
