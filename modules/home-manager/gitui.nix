{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;

  cfg = config.programs.gitui.catppuccin;
  enable = cfg.enable && config.programs.gitui.enable;
in
{
  options.programs.gitui.catppuccin = lib.ctp.mkCatppuccinOpt "gitui";

  config.programs.gitui = lib.mkIf enable {
    theme = builtins.path {
      name = "${cfg.flavor}.ron";
      path = "${sources.gitui}/theme/${cfg.flavor}.ron";
    };
  };
}
