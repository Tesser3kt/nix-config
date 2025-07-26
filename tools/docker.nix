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

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
}
