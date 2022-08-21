# darkplus colourscheme for Neovim written in Lua
# from https://github.com/LunarVim/darkplus.nvim

{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "lunarvim-darkplus";

  src = fetchFromGitHub {
    owner = "LunarVim";
    repo = "darkplus.nvim";
    rev = "49cfa2b2aaea0389436e6bc220a92c998249d10f";
    sha256 = "1c2spdx4jvv7j52f37lxk64m3rx7003whjnra3y1c7m2d7ljs6rb";
    # change to the value suggested by the error
  };
}
