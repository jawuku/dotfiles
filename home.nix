
{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    bat
    exa
    neofetch
    kitty
    htop
    most
    neovim
    tree-sitter
    rPackages.languageserver
    rPackages.tidyverse
    rPackages.devtools
    rPackages.IRkernel
    rPackages.ggplot2
    rPackages.lintr
    rPackages.styler
    python39
    python39Packages.sympy
    python39Packages.seaborn
    python39Packages.notebook
    python39Packages.numpy
    python39Packages.matplotlib
    python39Packages.scikit-learn
    python39Packages.pandas
    python39Packages.scipy
    python39Packages.gmpy2
    python39Packages.pillow-simd
    nodePackages.pyright
    nodePackages.bash-language-server
    # julia_17-bin # only for x86_64
    clojure
    clojure-lsp
    leiningen
    clang
    clang-tools
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
      lt = "exa --tree";
      update  = "sudo nix-channel update";
      upgrade = "sudo nixos-rebuild switch";
    };
    
    sessionVariables = {
      EDITOR = "nano";
      TERM = "kitty";
      PAGER = "most";
    };
  };
  
  programs.neovim = {
    enable = true;
    vimAlias = false;

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
	    telescope-fzy-native
	    cmp_luasnip
	    luasnip
	    tender-vim
	    NeoSolarized
	    nvim-autopairs
	    vim-code-dark
	  ];
	
	  extraConfig = ''
	    lua << EOF
	      ${builtins.readFile /home/jason/.config/nvim/user/setup_plugins.lua}
              ${builtins.readFile /home/jason/.config/nvim/user/options.lua}
	      ${builtins.readFile /home/jason/.config/nvim/user/keymaps.lua}
	      ${builtins.readFile /home/jason/.config/nvim/user/lsp_setup.lua}
	    EOF
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
