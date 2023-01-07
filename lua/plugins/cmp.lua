-- Completions
local cmp = require'cmp'
local lspkind = require'lspkind'

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine' },
  },
  snippet = {
	  expand = function(args)
	    vim.fn["vsnip#anonymous"](args.body)
          end,
  },
  formatting = {
  	format = function(entry, vim_item)
  		-- if you have lspkind installed, you can use it like
  		-- in the following line:
   		vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
   		vim_item.menu = source_mapping[entry.source.name]
   		if entry.source.name == "cmp_tabnine" then
   			local detail = (entry.completion_item.data or {}).detail
   			vim_item.kind = ""
   			if detail and detail:find('.*%%.*') then
   				vim_item.kind = vim_item.kind .. ' ' .. detail
   			end
  
   			if (entry.completion_item.data or {}).multiline then
   				vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
   			end
   		end
   		local maxwidth = 80
   		vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
   		return vim_item
    end,
  },
  window = {
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }, {
    { name = 'buffer' },
  }),
})

require'plugins.lsp'

--require("mason-lspconfig").setup_handlers {
--    -- The first entry (without a key) will be the default handler
--    -- and will be called for each installed server that doesn't have
--    -- a dedicated handler.
--    function (server_name) -- default handler (optional)
--        require("lspconfig")[server_name].setup {}
--    end,
--    -- Next, you can provide a dedicated handler for specific servers.
--    -- For example, a handler override for the `rust_analyzer`:
--    --["rust_analyzer"] = function ()
--    --    require("rust-tools").setup {}
--    --end
--}

