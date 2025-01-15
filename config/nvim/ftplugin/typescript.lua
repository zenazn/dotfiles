-- vim.lsp.set_log_level("TRACE")

vim.lsp.start({
  name = 'tsserver',
  cmd = {'bunx', 'typescript-language-server', '--stdio'},
  root_dir = vim.fs.dirname(vim.fs.find({'bun.lockb', 'pnpm-lock.yaml', 'package-lock.json', 'yarn.lock'}, { upward = true })[1]),
  -- https://github.com/typescript-language-server/typescript-language-server/issues/711
  init_options = {completionDisableFilterText = true}
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set('n', '<C-}>', vim.lsp.buf.type_definition, { buffer = args.buf })
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set('n', '<F5>', vim.lsp.buf.code_action, { buffer = args.buf })
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = args.buf })
  end,
})

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config({
  virtual_text = false, -- Turn off inline diagnostics
  severity_sort = true,
})

-- Use this if you want it to automatically show all diagnostics on the
-- current line in a floating window. Personally, I find this a bit
-- distracting and prefer to manually trigger it (see below). The
-- CursorHold event happens when after `updatetime` milliseconds. The
-- default is 4000 which is much too long
-- vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float()')
-- vim.o.updatetime = 300

-- Show all diagnostics on current line in floating window
vim.api.nvim_set_keymap(
  'n', '<Leader>d', ':lua vim.diagnostic.open_float()<CR>',
  { noremap = true, silent = true }
)
-- Go to next diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', '<Leader>n', ':lua vim.diagnostic.goto_next()<CR>',
  { noremap = true, silent = true }
)
-- Go to prev diagnostic (if there are multiple on the same line, only shows
-- one at a time in the floating window)
vim.api.nvim_set_keymap(
  'n', '<Leader>p', ':lua vim.diagnostic.goto_prev()<CR>',
  { noremap = true, silent = true }
)

-- TODO:
-- - rename
-- - add import (better)
-- - the whole command palette window
-- - restore formatting (for comment wrapping)
