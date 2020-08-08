call minpac#add('neovim/nvim-lsp')
call minpac#add('nvim-lua/diagnostic-nvim')
let g:diagnostic_enable_underline = 1
let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_insert_delay = 1

nmap <silent> [W :FirstDiagnostic<cr>
nmap <silent> [w :PrevDiagnosticCycle<cr>
nmap <silent> ]w :NextDiagnosticCycle<cr>
nmap <silent> ]W :LastDiagnostic<cr>

call sign_define("LspDiagnosticsErrorSign", {"text" : ">>", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "--", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "!!", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "??", "texthl" : "LspDiagnosticsHint"})

" lua require'nvim_lsp'.pyls.setup{on_attach=require'diagnostic'.on_attach}

lua << EOF
vim.cmd('packadd diagnostic-nvim')
vim.cmd('packadd nvim-lsp')

local lsp = require 'nvim_lsp'
local nvim_command = vim.api.nvim_command

local on_attach = function(client)
  require'diagnostic'.on_attach()
  nvim_command("autocmd CursorHold <buffer> lua require'jumpLoc'.openLineDiagnostics()")
end

lsp.cssls.setup{on_attach = on_attach}
lsp.html.setup{on_attach = on_attach}
lsp.jsonls.setup{on_attach = on_attach}
lsp.pyls.setup{on_attach = on_attach}
lsp.solargraph.setup{
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}
lsp.tsserver.setup{on_attach = on_attach}
lsp.vimls.setup{on_attach = on_attach}
lsp.vuels.setup{on_attach = on_attach}
lsp.yamlls.setup{on_attach = on_attach}
EOF

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

