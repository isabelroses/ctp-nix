{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.programs.alacritty.catppuccin;
  enable = cfg.enable && config.programs.alacritty.enable;
in
{
  options.programs.alacritty.catppuccin = lib.ctp.mkCatppuccinOpt "alacritty";

  config.programs.alacritty = lib.mkIf enable {
    settings = lib.importTOML "${sources.alacritty}/catppuccin-${cfg.flavor}.toml";
  };
}
