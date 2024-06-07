{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.i18n.inputMethod.fcitx5.catppuccin;
  enable = cfg.enable && config.i18n.inputMethod.enabled == "fcitx5";
in
{
  options.i18n.inputMethod.fcitx5.catppuccin = lib.ctp.mkCatppuccinOpt "Fcitx5" // {
    apply = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Applies the theme by overwriting `$XDG_CONFIG_HOME/fcitx5/conf/classicui.conf`.
        If this is disabled, you must manually set the theme (e.g. by using `fcitx5-configtool`).
      '';
    };
  };

  config.xdg = lib.mkIf enable {
    dataFile."fcitx5/themes/catppuccin-${cfg.flavor}" = {
      source = "${sources.fcitx5}/src/catppuccin-${cfg.flavor}";
      recursive = true;
    };

    configFile."fcitx5/conf/classicui.conf" = lib.mkIf cfg.apply {
      text = lib.generators.toINIWithGlobalSection { } {
        globalSection.Theme = "catppuccin-${cfg.flavor}";
      };
    };
  };
}
