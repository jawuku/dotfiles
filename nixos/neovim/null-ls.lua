--[[
                               
                        88 88  
                        88 88  
                        88 88  
8b,dPPYba,  88       88 88 88  
88P'   `"8a 88       88 88 88  8888888888
88       88 88       88 88 88  
88       88 "8a,   ,a88 88 88  
88       88  `"YbbdP'Y8 88 88  
                               
                        
88          ad88888ba   
88         d8"     "8b  
88         Y8,          
88         `Y8aaaaa,    
88           `"""""8b,  
88                 `8b  
88         Y8a     a8P  
88888888888 "Y88888P"   
                       
ASCII art from www.ascii.co.uk/text
Style: Default Font
]]

local null_ls = require("null-ls")

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- formatting sources
local formatting = null_ls.builtins.formatting

local sources = {
    null_ls.builtins.formatting.isort,
	null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.joker,
	null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.styler,
	null_ls.builtins.formatting.beautysh,
	null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.diagnostics.trail_space,
    null_ls.builtins.diagnostics.clj_kondo
}

null_ls.setup({ sources = sources })