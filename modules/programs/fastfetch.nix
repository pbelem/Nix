# --- Kitty Session ---
  xdg.configFile."kitty/session.conf".text = ''
    launch --hold fastfetch
  '';

  # --- Fastfetch Config (JSONC) ---
  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "logo": {
        // "source": "~/.config/fastfetch/aesthetic.jpg",
        "type": "kitty",
        "height": 16,
        "padding": {
          "top": 0
        }
      },
      "display": {
        "separator": "- "
      },
      "modules": [
        {
          "type": "custom",
          "format": "\u001b[31m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  "
        },
        "break",
        {
          "type": "title",
          "keyWidth": 10
        },
        "break",
        {
          "type": "os",
          "key": " ", 
          "keyColor": "34"
        },
        {
          "type": "kernel",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "packages",
          "format": "{} (nix)", 
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "shell",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "terminal",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "wm",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "cursor",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "terminalfont",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "uptime",
          "key": " ",
          "keyColor": "34"
        },
        {
          "type": "datetime",
          "format": "{1}-{3}-{11}",
          "key": " ",
          "keyColor": "34"
        },
        "break",
        {
          "type": "custom",
          "format": "\u001b[31m  \u001b[31m  \u001b[32m  \u001b[33m  \u001b[34m  \u001b[35m  \u001b[36m  "
        },
        "break",
        "break"
      ]
    }
  '';
