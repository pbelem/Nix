programs.keepassxc = {
    enable = true;
    settings = {
      General = {
        MinimizeAfterUnlock = true;
      };
      GUI = {
        MinimizeOnStartup = true;
      };
      Browser = {
        Enabled = true;
        ShowNotification = true;
        BestMatchOnly = false;
        UnlockDatabase = true;
        MatchUrlScheme = true;
        SupportBrowserProxy = true;
        UseCustomProxy = false;          # Uses the package's native proxy
      };
    };
  };
