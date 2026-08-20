{config, ...}: let
  containers = config.programs.zen-browser.profiles.default.containers;
  spaces = config.programs.zen-browser.profiles.default.spaces;
in {
  programs.zen-browser.profiles.default = {
    pinsForce = true;
    pinsForceAction = "demote";
    pins = rec {
      youtube = {
        title = "YouTube";
        id = "d4d74493-0801-4b60-ad15-d9adcc120db1";
        url = "https://www.youtube.com";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 0;
        isEssential = true;
      };

      github-developer = {
        title = "GitHub";
        id = "777a6f69-cdfb-43c4-b348-5ce733495556";
        url = "https://github.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1;
        isEssential = true;
      };

      chatgpt = {
        title = "ChatGPT";
        id = "71303e8b-3399-4c6a-a323-3ebd5c685824";
        url = "https://chatgpt.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1000;
      };

      notion = {
        title = "Notion";
        id = "534eed63-5da2-4806-837a-8a2f5cf7a263";
        url = "https://app.notion.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1100;
      };

      homelab-folder = {
        title = "Homelab";
        id = "6c3e6aa6-6e5e-4226-8d21-23de209246af";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1200;
        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = false;
        folderIcon = "🏠";
      };

      tailscale = {
        title = "Tailscale";
        id = "c36a74a1-a4db-42f2-ba28-b979dcbd19cc";
        url = "https://login.tailscale.com/admin/machines";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1201;
      };

      cloudflare = {
        title = "Cloudflare";
        id = "1487afb6-7050-4883-978c-a1735a3a74a6";
        url = "https://dash.cloudflare.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1202;
      };

      homepage = {
        title = "Homepage";
        id = "e742eea4-2fc3-4cdf-a168-f408f244500b";
        url = "https://home.ridewithmin.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1203;
      };

      git-with-min = {
        title = "Git with Min!";
        id = "36aab7c0-4398-4d0a-a6ec-df4f99618d92";
        url = "https://git.ridewithmin.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1204;
      };

      vaultwarden = {
        title = "Vaultwarden";
        id = "84c31b0a-e043-4899-8511-903d0a28f641";
        url = "https://vault.ridewithmin.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1205;
      };

      uptime = {
        title = "Uptime";
        id = "9538e4dd-486c-4e6e-8e9c-19df2d12e38b";
        url = "https://status.ridewithmin.com/status";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1206;
      };

      beszel = {
        title = "Beszel";
        id = "834114ef-19ce-4291-8f2e-1e39fc02a4a7";
        url = "https://beszel.ridewithmin.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1207;
      };

      adguardhome = {
        title = "AdGuard Home";
        id = "602d1884-d045-4dfb-8b7c-2b2b3e2b6e37";
        url = "https://adguardhome.ridewithmin.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1208;
      };

      homelab-docs = {
        title = "Homelab Documentation";
        id = "d7ceff41-a9c7-4c5d-aeb8-9591a23acab8";
        url = "https://docs.ridewithmin.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1209;
      };

      dev-with-min = {
        title = "Dev with Min";
        id = "198aeb98-4fcc-4d5d-9a99-9635087c1aea";
        url = "https://blog.ridewithmin.com";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1210;
      };

      jamye-plz = {
        title = "잼얘좀";
        id = "66912253-de96-4218-a757-98462ab09628";
        url = "https://jamye-plz.ridewithmin.com/groups";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = homelab-folder.id;
        position = 1211;
      };

      nix-folder = {
        title = "Nix";
        id = "1a16dcb7-aa4d-4c06-8efd-6719d9791483";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        position = 1400;
        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = false;
        folderIcon = "❄️";
      };

      nixos-search = {
        title = "NixOS Search";
        id = "53ec9929-f070-4587-a280-e5cfc37882b7";
        url = "https://search.nixos.org/packages";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1401;
      };

      home-manager-search = {
        title = "Home Manager Search";
        id = "1fdbdcc2-ba02-4733-90c1-f1557e6e6dfb";
        url = "https://home-manager-options.extranix.com/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1402;
      };

      nix-dev = {
        title = "Nix.dev";
        id = "7e8cde9d-8336-41b7-8abf-719139b3f5c6";
        url = "https://nix.dev/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1403;
      };

      nix-ee = {
        title = "Searchix";
        id = "b5dbc6b7-d86e-4d1c-8262-433bf678b2cc";
        url = "https://search.nix.ee/";
        workspace = spaces.developer.id;
        container = containers.personal.id;
        folderParentId = nix-folder.id;
        position = 1404;
      };

      tossinvest = {
        title = "토스증권";
        id = "c1447c1b-00b3-4078-b430-0e4262f9fd70";
        url = "https://www.tossinvest.com/";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2000;
      };

      okx = {
        title = "OKX";
        id = "aada8b65-d9e8-4a73-8618-a3bb02261f21";
        url = "https://www.okx.com/markets/prices";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2100;
      };

      bithumb = {
        title = "Bithumb";
        id = "dba959d9-d1d1-40c0-bbae-72d6c0fe63d4";
        url = "https://www.bithumb.com/react/trade/order/ETH-KRW";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2200;
      };

      investing-dot-com = {
        title = "Investing.com";
        id = "5c313f11-e48a-4949-bb2b-6afaa5a535d7";
        url = "https://www.investing.com";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2300;
      };

      real-estate-folder = {
        title = "Real Estate";
        id = "ef2c4075-24a9-4b90-b4d7-4bc5ad0f6a9b";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2400;
        isGroup = true;
        editedTitle = true;
        isFolderCollapsed = false;
        folderIcon = "🏠";
      };

      naver-real-estate = {
        title = "Npay 부동산";
        id = "8fa11177-59f7-48f4-8eff-a874fd3c528f";
        url = "https://fin.land.naver.com/map";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2401;
      };

      lh-apply = {
        title = "LH청약";
        id = "fc5442a3-2ddd-4c98-a596-d0113e275d98";
        url = "https://apply.lh.or.kr/lhapply/apply/main.do";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2402;
      };

      sh-apply = {
        title = "SH청약";
        id = "9150937c-b9fa-42dc-aedd-c5bd2791b2fa";
        url = "https://www.i-sh.co.kr/app/index.do";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2403;
      };

      applyhome = {
        title = "청약홈";
        id = "e46ba570-22cd-49dd-b31d-f580f996a6e6";
        url = "https://www.applyhome.co.kr/co/coa/selectMainView.do";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2404;
      };

      ayoung-home = {
        title = "아영이네 행복주택";
        id = "e3ca858e-06a0-4b8d-83f4-62c3ef7f9ace";
        url = "https://www.ayounghome.com/";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2405;
      };

      ayoung-cafe = {
        title = "아영이네 카페";
        id = "a6ab76f6-edd7-41f3-a7c4-dfc3ab87a331";
        url = "https://cafe.naver.com/ayshh";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        folderParentId = real-estate-folder.id;
        position = 2406;
      };

      gov24 = {
        title = "정부24";
        id = "8d26c1dc-a9b0-4b91-81fd-584fba99ed9c";
        url = "https://plus.gov.kr/";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2500;
      };

      hometax = {
        title = "홈택스";
        id = "6e2a17b3-3192-418d-b4a8-a6eead3cda7c";
        url = "https://hometax.go.kr/websquare/websquare.html?w2xPath=/ui/pp/index_pp.xml&menuCd=index3";
        workspace = spaces.finance.id;
        container = containers.personal.id;
        position = 2600;
      };

      tving = {
        title = "TVING";
        id = "93656f73-34e3-4641-b8a2-b6178bf3163f";
        url = "https://www.tving.com/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3000;
      };

      coupangplay = {
        title = "쿠팡플레이";
        id = "b4f99e8f-3c56-4197-bb26-f883555c8bf7";
        url = "https://www.coupangplay.com/home";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3100;
      };

      wavve = {
        title = "Wavve(웨이브)";
        id = "dc9d80f0-96ee-4388-b854-277fc7cca3fa";
        url = "https://www.wavve.com/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3200;
      };

      instagram = {
        title = "Instagram";
        id = "101d95d5-8326-4092-827b-160bd78a12ad";
        url = "https://www.instagram.com/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3300;
      };

      toeic = {
        title = "TOEIC® 공식 사이트";
        id = "0b0b2e7c-0b05-418f-844f-f300398bffcd";
        url = "https://exam.toeic.co.kr/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3400;
      };

      g-telp = {
        title = "G-TELP";
        id = "f80ca938-f605-48aa-87ab-7b2f4e7daacb";
        url = "https://www.g-telp.co.kr:335/";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3500;
      };

      beside-global = {
        title = "비사이드글로벌";
        id = "bf54b3e5-e82a-44a5-9056-d001d01d4b19";
        url = "https://beside-global.daouoffice.com/home";
        workspace = spaces.playground.id;
        container = containers.personal.id;
        position = 3600;
      };
    };
  };
}
