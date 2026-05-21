  programs.noctalia-shell = {
    enable = true;
    settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)) // {
      "shell.port" = 8180; 
    };
  };
