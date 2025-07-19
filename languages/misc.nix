{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    docker-language-server
    docker-buildx
  ];
}
