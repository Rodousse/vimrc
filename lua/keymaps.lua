local G = {}

function G.setup_keymaps()
  local opts = { noremap=true, silent=true }

  vim.api.nvim_set_keymap("t", "<esc>", "<C-\\><C-n>", {noremap = true})
  vim.api.nvim_set_keymap("n", "<leader>h", ":ClangdSwitchSourceHeader<CR>", opts)

  -- Use <Tab> and <S-Tab> to navigate through snippet placeholder
  vim.api.nvim_set_keymap('i', "<Tab>", 'pumvisible()?"<C-n>":"<Tab>"', {noremap = true, expr = true})
  vim.api.nvim_set_keymap('i', "<S-Tab>", 'pumvisible()?"<C-p>":"<S-Tab>"', {noremap = true, expr = true})
  vim.api.nvim_set_keymap("i", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)'      : '<Tab>'", {expr = true})
  vim.api.nvim_set_keymap("s", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)'      : '<Tab>'", {expr = true})
  vim.api.nvim_set_keymap("i", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", {expr = true})
  vim.api.nvim_set_keymap("s", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", {expr = true})
  vim.api.nvim_set_keymap("n", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'", {expr = true})

  -- File
  vim.api.nvim_set_keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>fe", ":lua require('telescope.builtin').live_grep()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>fE", ":lua require('telescope.builtin').grep_string()<CR>", opts)

  -- Git 
  local tel = require("telescope.builtin")
  vim.api.nvim_set_keymap("n", "<leader>gs", ":lua require('telescope.builtin').git_status()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>gc", ":lua require('telescope.builtin').git_commits()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>gC", ":lua require('telescope.builtin').git_bcommits()<CR>", opts)
  vim.api.nvim_set_keymap("n", "<leader>gb", ":lua require('telescope.builtin').git_branches()<CR>", opts)
end

local keymap_opts = { noremap=true, silent=true }
function G.setup_buf_lsp_keymaps(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  buf_set_keymap("n", "<leader>p", "<cmd>lua vim.lsp.buf.hover()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>rf", "<cmd>lua vim.lsp.buf.code_action()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>R", "<cmd>lua vim.lsp.buf.references()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>fs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>fS", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>fq", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>jd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>jD", "<cmd>vs<CR><C-w><C-w>\
                                     <cmd>lua require('telescope.builtin').lsp_definitions()<CR>", keymap_opts)
  buf_set_keymap("n", "<leader>jt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>()", keymap_opts)
  buf_set_keymap("n", "<leader>jT", "<cmd>vs<CR><C-w><C-w>\
                                     <cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", keymap_opts)
end

function G.setup_buf_lsp_format_keymaps(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", keymap_opts)
end

function G.setup_buf_lsp_format_range_keymaps(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", keymap_opts)
end

local cmp = require('cmp')
G.completion_keymaps = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm{ behavior = cmp.ConfirmBehavior.Replace, select = true },
}

local tel_actions = require("telescope.actions")
G.telescope_keymaps = {
  n = {},
  i = {
    ["<C-c>"] = false,
    ["<esc>"] = tel_actions.close
  }
}

return G
