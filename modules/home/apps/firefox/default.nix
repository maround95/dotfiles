{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.custom.apps.firefox;
  firefox-addons = inputs.firefox-addons.packages.${system};

  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "133.0";
    hash = "sha256-Uu/a5t74GGvMIJP5tptqbiFiA+x2hw98irPdl8ynGoE=";
  };
in
{
  options.custom.apps.firefox = with types; {
    enable = mkBoolOpt true "Whether or not to enable Firefox.";
  };

  config = mkIf cfg.enable {
    xdg.configFile."custom/vimium-c.json".source = ./vimium-c.json; # Import manually

    programs.firefox = {
      enable = true;

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
          @import url("${inputs.firefox-csshacks}/chrome/navbar_tabs_responsive_oneliner.css");

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
            #identity-box,
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
          "browser.startup.page" = 3; # Resume previous session on startup
          "browser.aboutConfig.showWarning" = false; # I sometimes know what I'm doing
          "browser.ctrlTab.sortByRecentlyUsed" = false; # (default) Who wants that?
          "browser.download.useDownloadDir" = true; # Ask where to save stuff
          "privacy.clearOnShutdown.history" = false; # We want to save history on exit
          # Hi-DPI
          # "layout.css.devPixelsPerPx" = "1.5";
          # Allow executing JS in the dev console
          "devtools.chrome.enabled" = true;
          # Disable browser crash reporting
          "browser.tabs.crashReporting.sendReport" = false;
          # Allow userCrome.css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # Why the fuck can my search window make bell sounds
          "accessibility.typeaheadfind.enablesound" = false;
          # Why the fuck can my search window make bell sounds
          "general.autoScroll" = true;

          # Hardware acceleration
          # See https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          # "media.rdd-ffmpeg.enabled" = true;
          # "widget.dmabuf.force-enabled" = true;
          # "media.av1.enabled" = false; # XXX: change once I've upgraded my GPU
          # # XXX: what is this?
          # "media.ffvpx.enabled" = false;
          # "media.rdd-vpx.enabled" = false;

          # Privacy
          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;

          "browser.send_pings" = false; # (default) Don't respect <a ping=...>

          # This allows firefox devs changing options for a small amount of users to test out stuff.
          # Not with me please ...
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;

          "beacon.enabled" = false; # No bluetooth location BS in my webbrowser please
          "device.sensors.enabled" = false; # This isn't a phone
          "geo.enabled" = false; # Disable geolocation alltogether

          # ESNI is deprecated ECH is recommended
          "network.dns.echconfig.enabled" = true;

          # Disable telemetry for privacy reasons
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.enabled" = false; # enforced by nixos
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.unified" = false;
          "extensions.webcompat-reporter.enabled" = false; # don't report compability problems to mozilla
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.urlbar.eventTelemetry.enabled" = false; # (default)

          # Disable some useless stuff
          "extensions.pocket.enabled" = false; # disable pocket, save links, send tabs
          "extensions.abuseReport.enabled" = false; # don't show 'report abuse' in extensions
          "extensions.formautofill.creditCards.enabled" = false; # don't auto-fill credit card information
          "identity.fxaccounts.enabled" = false; # disable firefox login
          "identity.fxaccounts.toolbar.enabled" = false;
          "identity.fxaccounts.pairing.enabled" = false;
          "identity.fxaccounts.commands.enabled" = false;
          "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
          "browser.uitour.enabled" = false; # no tutorial please
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # disable EME encrypted media extension (Providers can get DRM
          # through this if they include a decryption black-box program)
          "browser.eme.ui.enabled" = false;
          "media.eme.enabled" = false;

          # don't predict network requests
          "network.predictor.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;

          # disable annoying web features
          "dom.push.enabled" = false; # no notifications, really...
          "dom.push.connection.enabled" = false;
          "dom.battery.enabled" = false; # you don't need to see my battery...
          "dom.private-attribution.submission.enabled" = false; # No PPA for me pls
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

              url = [
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
