{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Global policy settings (Telemetry and bloat disabling)
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFeedbackCommands = true;

      DisableDeveloperTools = false;

      DontCheckDefaultBrowser = true;

      OfferToSaveLogins = false;

      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      NoDefaultBookmarks = true;

      # Forces native Wayland usage for maximum performance (240Hz without lag)
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
    };

    # Main profile configuration
    profiles.belem = {
      id = 0;
      name = "belem";
      isDefault = true;

      # Fine-tuned about:config settings for performance, privacy, and rendering
      settings = {

        # --- Performance and Native Wayland ---
        "gfx.webrender.all" = true; # Forces AMD GPU hardware acceleration
        "widget.wayland.fractional-scale-mode" = 1; # Better rendering with Wayland
        "dom.webgpu.enabled" = true; # Enables experimental WebGPU support

        # --- Strict Privacy (Anti-Fingerprinting) ---
        "privacy.sanitize.sanitizeOnShutdown" = false; # Manual history control

        # Enable only if necessary
        # (may break 240Hz rendering in canvas-based applications)
        "privacy.resistFingerprinting" = false;

        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        # Prevents tracking through battery level
        "dom.battery.enabled" = false;

        # --- Bloatware and Redirect Disabling ---
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        # Removes Pocket from the New Tab page
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

        # --- Visual Comfort and Integration ---
        "browser.uidensity" = 1; # Compact mode to save screen space

        # Allows custom themes to read system colors
        "svg.context-properties.content.enabled" = true;
      };
    };
  };
}
