{ ... }:
{
  flake.modules.homeManager.firefox =
    { inputs, pkgs, config, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      betterfox = inputs.self.packages.${system}.betterfox;
      firefox-csshacks = inputs.self.packages.${system}.firefox-csshacks;
      firefox-addons = inputs.firefox-addons.packages.${system};
    in
    {
      xdg.configFile."custom/vimium-c.json".source = ./firefox/vimium-c.json;

      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        policies = {
          SearchEngines = {
            Default = "ddg";
          };
        };

        profiles.default = {
          id = 0;
          isDefault = true;

          extraConfig = builtins.concatStringsSep "\n" [
            (builtins.readFile "${betterfox}/Securefox.js")
            (builtins.readFile "${betterfox}/Fastfox.js")
            (builtins.readFile "${betterfox}/Peskyfox.js")
          ];

          extensions.packages = with firefox-addons; [
            old-reddit-redirect
            ublock-origin
            vimium-c
          ];

          userChrome = ''
            @import url("${firefox-csshacks}/chrome/navbar_tabs_responsive_oneliner.css");

            :root
            {
              --toolbox-background-color: ActiveCaption;
              --toolbox-transparency: 50%;

              --toolbarbutton-hover-background: color-mix(in srgb, currentColor 17%, transparent) !important;
              --toolbarbutton-active-background: color-mix(in srgb, currentColor 30%, transparent) !important;
              --toolbar-transparency-level: 50%;

              #nav-bar,
              #PersonalToolbar
              {
                background-color: transparent !important;
                border-top: 0 !important;
              }

              #alltabs-button,
              /* #identity-box, */
              #urlbar-background,
              #titlebar-buttonbox-container,
              .titlebar-spacer
              {
                display: none !important;
              }

              .urlbarView {
                background-color: var(--toolbox-background-color) !important;
              }

              #navigator-toolbox
              {
                background-color: color-mix(in srgb, var(--toolbox-background-color), transparent var(--toolbox-transparency)) !important;
              }

              .tabbrowser-tab[visuallyselected] .tab-background
              {
                background-color: color-mix(in srgb, var(--toolbar-bgcolor), transparent var(--toolbar-transparency-level)) !important;

                &::before,
                &::after
                {
                  background-color: color-mix(in srgb, var(--toolbar-bgcolor), transparent var(--toolbar-transparency-level)) !important;
                }
              }
            }
          '';

          settings = {
            # General
            "intl.accept_languages" = "en-US,en";
            "browser.startup.page" = 3;
            "browser.aboutConfig.showWarning" = false;
            "browser.ctrlTab.sortByRecentlyUsed" = false;
            "browser.download.useDownloadDir" = true;
            "privacy.clearOnShutdown.history" = false;
            "devtools.chrome.enabled" = true;
            "browser.tabs.crashReporting.sendReport" = false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "accessibility.typeaheadfind.enablesound" = false;
            "general.autoScroll" = true;

            # Hardware acceleration
            "gfx.webrender.all" = true;
            "media.ffmpeg.vaapi.enabled" = true;

            # Privacy
            "privacy.donottrackheader.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.userContext.enabled" = true;
            "privacy.userContext.ui.enabled" = true;

            "browser.send_pings" = false;

            "app.normandy.enabled" = false;
            "app.shield.optoutstudies.enabled" = false;

            "beacon.enabled" = false;
            "device.sensors.enabled" = false;
            "geo.enabled" = false;

            "network.dns.echconfig.enabled" = true;

            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.server" = "";
            "toolkit.telemetry.unified" = false;
            "extensions.webcompat-reporter.enabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "browser.ping-centre.telemetry" = false;
            "browser.urlbar.eventTelemetry.enabled" = false;

            "extensions.pocket.enabled" = false;
            "extensions.abuseReport.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "identity.fxaccounts.enabled" = false;
            "identity.fxaccounts.toolbar.enabled" = false;
            "identity.fxaccounts.pairing.enabled" = false;
            "identity.fxaccounts.commands.enabled" = false;
            "browser.contentblocking.report.lockwise.enabled" = false;
            "browser.uitour.enabled" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

            "browser.eme.ui.enabled" = false;
            "media.eme.enabled" = false;

            "network.predictor.enabled" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;

            "dom.push.enabled" = false;
            "dom.push.connection.enabled" = false;
            "dom.battery.enabled" = false;
            "dom.private-attribution.submission.enabled" = false;
          };

          search = {
            force = true;
            default = "ddg";
            privateDefault = "ddg";
            order = [
              "ddg"
              "google"
            ];
            engines = {
              "bing".metaData.hidden = true;
              "ebay".metaData.hidden = true;
              "amazondotcom-us".metaData.hidden = true;
              "google".metaData.alias = "@g";
              "wikipedia".metaData.alias = "@wk";
              "youtube" = {
                icon = "https://youtube.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@yt" ];
                urls = [
                  {
                    template = "https://www.youtube.com/results";
                    params = [
                      {
                        name = "search_query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "Nix Packages" = {
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "NixOS Options" = {
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@no" ];
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "GitHub" = {
                icon = "https://github.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@gh" ];

                urls = [
                  {
                    template = "https://github.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "Home Manager" = {
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@hm" ];

                urls = [
                  {
                    template = "https://mipmip.github.io/home-manager-option-search/";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };

              "Crates.io" = {
                urls = [ { template = "https://crates.io/crates/{searchTerms}"; } ];
                definedAliases = [ "@cio" ];
              };
            };
          };
          bookmarks = { };
        };
      };

      xdg.mimeApps.defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "text/xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
}
