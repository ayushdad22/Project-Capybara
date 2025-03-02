{ pkgs, lib, config, ... }: {
  # https://devenv.sh/languages/elixir/
  languages.elixir.enable = true;
  languages.erlang.enable = true;
  
  # See full reference at https://devenv.sh/reference/options/

  scripts.setup.exec = ''
    mix ecto.create
  '';
  packages = with pkgs; [
    inotify-tools
  ];

  services.postgres = {
    enable = true;
    initialDatabases = [
      {
        name = "capybara_dev";
        user = "capybaralovers";
        pass = "Brianisthegoat";
      }
    ];
    listen_addresses = "127.0.0.1";
  };

  processes = {
    server.exec = "mix phx.server";
  };
}
