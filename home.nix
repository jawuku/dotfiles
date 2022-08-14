
{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    bat
    exa
    neofetch
    htop
    most
    tree-sitter
    R
    rPackages.languageserver
    rPackages.tidyverse
    rPackages.devtools
    rPackages.IRkernel
    rPackages.ggplot2
    rPackages.lintr
    rPackages.styler
   # python310Packages.sympy
   # python310Packages.seaborn
   # python310Packages.notebook
   # python310Packages.numpy
   # python310Packages.matplotlib
   # python310Packages.scikit-learn
   # python310Packages.pandas
   # python310Packages.scipy
   # python310Packages.gmpy2
   # python310Packages.pillow-simd
    nodePackages.pyright
    nodePackages.bash-language-server
    julia_17-bin # only for x86_64
    clojure
    clojure-lsp
    leiningen
    clang
    clangd
    clang-format
    octaveFull
    fzf
    ripgrep
    sumneko-lua-language-server
  ];
  
  programs.bat.enable = true;
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    
    shellAliases = {
      cat = "bat";
      ls  = "exa";
      ll  = "exa -la --icons";
      lt  = "exa --tree";
      update  = "sudo nix-channel update";
      upgrade = "sudo nixos-rebuild switch";
    };
    
    sessionVariables = {
      EDITOR = "nano";
      TERM   = "kitty";
      PAGER  = "most";
    };
  };
  
  programs.neovim = {
    package = pkgs.neovim-unwrapped;
    enable =      true;
    vimAlias   = false;
    withPython3 = true;
    withNodeJs  = true;
    
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      nvim-web-devicons
      lualine-nvim
      bufferline-nvim
      comment-nvim
      nvim-treesitter
      nvim-ts-rainbow
      indent-blankline-nvim
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      cmp_luasnip
      luasnip
      tender-vim
      NeoSolarized
      nvim-autopairs
      vim-code-dark
    ];
	
      extraConfig = ''
	" download following 4 files from https://github.com/
        " cd /etc/nixos/
        " wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/lua/user/setup_plugins.lua
        " wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/lua/user/options.lua
        " wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/lua/user/keymaps.lua
        " wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/lua/user/lsp_cmp_setup.lua
        
	luafile ${./setup_plugins.lua}
        luafile ${./options.lua}
	luafile ${./keymaps.lua}
	luafile ${./lsp_cmp_setup.lua}
	colorscheme codedark
	'';
  };
  
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      font_family      = "FiraCode Nerd Font";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      disable_ligatures = false;
      font_features = "+ss02 +ss08 +cv16 +ss05";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      remember_window_size = true;
      initial_window_width = "80c";
      initial_window_height = "25c";
    };
  };
}
