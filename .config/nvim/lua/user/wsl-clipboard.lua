--[[ Handle clipboard in WSL
From Mitchell Paulus (2022)
Title: WSL, Neovim, Lua and the Windows Clipboard
Website: mitchellt.com/2022/05/15/WSL-Neovim-Lua-and-the-Windows-Clipboard.html
(Accessed 20 May 2023)

First, ensure that the shell script file 'nvim_paste' is in the $PATH
```sh
#!/bin/sh

# Check for win32yank.exe executable
if command -v win32yank.exe >/dev/null 2>/dev/null; then
    # The --lf option pastes data unix style. Which is what I almost always want.
    win32yank.exe -o --lf
else
    # Else rely on PowerShell being installed and available.
    powershell.exe Get-Clipboard | tr -d '\r' | sed -z '$ s/\n$//'
fi
```
]]

in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true
    }
end
