-- Language Server configuration
-- Follow installation notes below before running the neovim LSP.

-- Julia language server - to install:
-- julia -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("SymbolServer")'
require'lspconfig'.julials.setup{}

-- Clojure language server - to install:
-- wget https://github.com/clojure-lsp/clojure-lsp/blob/master/install-latest-clojure-lsp.sh
-- chmod +x install-latest-clojure-lsp.sh
-- sudo ./install-latest-clojure-lsp.sh
require'lspconfig'.clojure_lsp.setup{}

-- Language server for Python
-- npm install -g pyright
require'lspconfig'.pyright.setup{}

-- R language server - to install:
-- R
-- install.packages("languageserver")
require'lspconfig'.r_language_server.setup{}
