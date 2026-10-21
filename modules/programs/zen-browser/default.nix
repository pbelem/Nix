{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    # Global policies (Telemetry, forms, and extensions)
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFeedbackCommands = true;
      DisableDeveloperTools = false;
      DontCheckDefaultBrowser = true;

      # Disable built-in password manager, addresses, and payments
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      NoDefaultBookmarks = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      ExtensionSettings = {
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };

        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        # Proton Pass
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
        };

        # Hide shorts for Youtube
        "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/hide-youtube-shorts/latest.xpi";
          installation_mode = "force_installed";
        };

        # ZeroDelay
        "zerodelay@joaogfc" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/zerodelay/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    # Fine-tuned about:config preferences applied to the default profile
    profiles.default = {
      id = 0;
      isDefault = true;

      # --- Search Engine Configuration ---
      search = {
        force = true;
        default = "brave-search";
        engines = {
          "brave-search" = {
            # Note: Home Manager uses {searchTerms} instead of %s
            urls = [{ template = "https://search.brave.com/search?q={searchTerms}&source=web"; }];
            definedAliases = [ "@b" ];
          };

          # Hiding unwanted default search engines
          "bing".metaData.hidden = true;
          "ddg".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
          "Perplexity".metaData.hidden = true;
        };
      };

      settings = {
        # --- Zen Browser Mods ---
        # Better Unloaded Tabs
        "zen.view.use-theme.f7c71d9a-bce2-420f-ae44-a64bd92975ab" = true;

        # --- Search & Address Bar Suggestions (Disabled) ---
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.clipboard" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.engines" = false;

        # --- Bookmarks Import ---
        # Copies the file to the Nix store and forces the browser to import it
        "browser.places.importBookmarksHTML" = true;
        "browser.bookmarks.file" = "${./bookmarks.html}";

        # --- Form Autofill & Password Manager Disabling ---
        "signon.rememberSignons" = false;
        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        # --- Performance and Native Wayland ---
        "gfx.webrender.all" = true;
        "widget.wayland.fractional-scale-mode" = 1;
        "dom.webgpu.enabled" = true;

        # --- Strict Privacy ---
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.resistFingerprinting" = false; # Preserves 240Hz in canvas
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "dom.battery.enabled" = false;

        # --- Telemetry and Feeds Disabling ---
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # --- Visual Integration ---
        "svg.context-properties.content.enabled" = true;
      };
    };
  };
}
