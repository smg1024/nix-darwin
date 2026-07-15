{config, ...}: let
  pins = config.programs.zen-browser.profiles.default.pins;
in {
  programs.zen-browser.profiles.default.joinedTabs = {
    finance-market = {
      name = "Market";
      id = "finance-market";
      gridType = "vsep";
      tabs = [
        pins.tradingview.id
        pins.okx.id
      ];
      sizes = [
        70
        30
      ];
    };
  };
}
