{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    docker
    docker-compose
    docker-buildx
  ];

  # Enable Docker service
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
}
