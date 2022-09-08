# Trial data science environment - Python, R, Octave, Julia

let
  pkgs = import <nixpkgs> {};
in

  pkgs.mkShell {
    name = "datasci";
    buildInputs = with pkgs; [
      python39
      python39Packages.numpy
      python39Packages.scipy
      python39Packages.scikitlearn
      python39Packages.matplotlib
      python39Packages.pandas
      python39Packages.gmpy2
      python39Packages.sympy
      python39Packages.seaborn
      python39Packages.notebook
      python39Packages.tensorflowWithoutCuda
      python39Packages.pytorchWithoutCuda
      python39Packages.black
      python39Packages.isort
      python39Packages.flake8
      python39Packages.pynvim
      
      # R
      R
      rPackages.devtools
      rPackages.tidyverse
      rPackages.ggplot2
      rPackages.IRkernel
      
      # GNU Octave
      octave
      octavePackages.io
      octavePackages.image
      octavePackages.statistics
      octavePackages.nan
      octavePackages.control
      octavePackages.optim
      octavePackages.signal
      
      # Julia
      julia_17-bin
      ];
      
    shellHook = ''
      julia -e 'using Pkg; Pkg.add(["IJulia", "LanguageServer"])';
      '';
}
