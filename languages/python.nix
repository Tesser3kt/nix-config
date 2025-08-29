{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    uv
    (python3.withPackages (p:
      with p; [
        python-lsp-server
        python-lsp-black
        pyls-isort
        pyls-flake8
        pylint
        black
        flake8
        rope
        pyflakes
        mccabe
        pycodestyle
        pydocstyle
        autopep8
        yapf
        isort
        pip
        virtualenv
        setuptools
        requests
        numpy
        pandas
        pyserial

        # lsprotocol temporary fix
        (lsprotocol.overridePythonAttrs (old: {
          version = "2023.0.1";

          src = fetchFromGitHub {
            owner = "microsoft";
            repo = "lsprotocol";
            tag = "2023.0.1";
            hash = "sha256-PHjLKazMaT6W4Lve1xNxm6hEwqE3Lr2m5L7Q03fqb68=";
          };
        }))
      ]))
  ];
}
