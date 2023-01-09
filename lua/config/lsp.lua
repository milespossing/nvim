local M = {}

local default_handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}
    --require'lspconfig'.pylsp.setup {
    --	capabilities = capabilities,
    --    on_attach = on_attach,
    --    flags = lsp_flags,
    --}
    --require'lspconfig'.sumneko_lua.setup {
    --	capabilities = capabilities,
    --    on_attach = on_attach,
    --    flags = lsp_flags,
    --}
    --require'lspconfig'.clangd.setup {
    --	capabilities = capabilities,
    --    on_attach = on_attach,
    --    flags = lsp_flags,
    --}
    --require'lspconfig'.tsserver.setup {
    --	capabilities = capabilities,
    --    on_attach = on_attach,
    --    flags = lsp_flags,
    --}
    --require'lspconfig'.rust_analyzer.setup {
    --	capabilities = capabilities,
    --    handlers = handlers,
    --    on_attach = on_attach,
    --    flags = lsp_flags,
    --}
local servers = {
    rust_analyzer = {
        handlers = default_handlers
    },
    pylsp = {
        handlers = default_handlers
    },
}

M.config = function()
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  -- Set up LSPs

  -- LSP settings (for overriding per client)
  local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  for name, config in pairs(servers) do
      config.capabilities = capabilities
      config.on_attach = on_attach
      config.flags = { debounce_text_changes = 150 }
      lspconfig[name].setup(config)
  end
end

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

return M
