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

        # for neomutt
        vobject
        icalendar
        pytz
        tzlocal
      ]))
  ];
}
