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

  # Allow the user to run Docker commands without sudo
  users.users.tesserekt.extraGroups = [
    "docker"
  ];
}
