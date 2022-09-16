{ config, pkgs, lib, vimUtils, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";
  
in {
  programs.neovim = {
    enable = true;
    # read in the vim config from filesystem
    # this enables syntaxhighlighting when editing those
    extraConfig = builtins.concatStringsSep "\n" [
      " (lib.strings.fileContents ./base.vim)
      " (lib.strings.fileContents ./plugins.vim)
      " (lib.strings.fileContents ./lsp.vim)

      # this allows you to add lua config files
      ''
        lua << EOF
        ${lib.strings.fileContents ./neovim/options.lua}
        ${lib.strings.fileContents ./neovim/keymaps.lua}
        ${lib.strings.fileContents ./neovim/which-key.lua}
        ${lib.strings.fileContents ./neovim/bufferline.lua}
        ${lib.strings.fileContents ./neovim/treesitter.lua}
        ${lib.strings.fileContents ./neovim/telescope.lua}
        ${lib.strings.fileContents ./neovim/cmp-lsp.lua}
        ${lib.strings.fileContents ./neovim/null-ls.lua}
		-- Extra plugin configurations
		
		-- Lualine
		require("lualine").setup {
          options = { theme = "solarized" } }
		
		-- Nvim-tree
		require("nvim-tree").setup{}
		
		-- nvim-autopairs
		require("nvim-autopairs").setup {
          disable_filetype = { "TelescopePrompt" , "vim" },
          check_ts = true,
        }
		
		-- null-ls
		require("null-ls").setup()
		EOF
		colorscheme solarized
    ''
    ];

    # install needed binaries here
    extraPackages = with pkgs; [
      # used to compile tree-sitter grammar
      tree-sitter

      # installs different langauge servers for neovim-lsp
      # have a look on the link below to figure out the ones for your languages
      # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      clojure-lsp
	    clj-kondo
	    joker
	    sumneko-lua-language-server
      nodePackages.pyright
	    nodePackages.bash-language-server
	    nodePackages.vim-language-server
	    nodePackages.neovim
	    black
      # beautysh # when merged into Nixpgs
    ];
	
    plugins = with pkgs.vimPlugins; [
      # you can use plugins from the pkgs
      tender-vim
	    plenary-nvim
	    nvim-web-devicons
	    (pkgs.nvim-treesitter.withPlugins (_: allGrammars))
      lualine-nvim
	    nvim-ts-rainbow
	    nvim-tree-lua
	    nvim-autopairs
	    telescope-nvim
	    telescope-fzf-native-nvim
	    which-key-nvim
	    nvim-lspconfig
	    cmp-nvim-lspconfig
	    cmp-nvim-lua
      cmp-buffer
	    cmp-path
	    cmp-cmdline
      cmp-conjure
	    nvim-cmp
	    luasnip
	    cmp_luasnip
	    friendly-snippets
	    lspkind-nvim
	    indent-blankline-nvim
	    null-ls-nvim
	  
      # or you can use our function to directly fetch plugins from git
      (plugin "LunarVim/darkplus.nvim") # darkplus nvim theme
      (plugin "shaunsingh/solarized.nvim") # nvim solarized theme
      (plugin "noib3/nvim-cokeline") # buffer line

      # this installs the plugin from 'nightly' branch
      #(pluginGit "nightly" "kyazdani42/nvim-web-devicons")
    ];
  };
}