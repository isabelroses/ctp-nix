{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.git.delta.catppuccin;
  enable = cfg.enable && config.programs.git.delta.enable;
in
{
  options.programs.git.delta.catppuccin = lib.ctp.mkCatppuccinOpt "catppuccin";

  config.programs.git = lib.mkIf enable {
    includes = [ { path = "${sources.delta}/catppuccin.gitconfig"; } ];
    delta.options.features = "catppuccin-${cfg.flavor}";
  };
}
