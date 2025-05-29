local G = {}

function G.setup_keymaps()
    local opts = { noremap = true, silent = true }

    vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true })
    vim.keymap.set("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
    vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float<CR>", opts)

    -- File
    vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
    vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
    vim.keymap.set("n", "<leader>fe", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
    vim.keymap.set("n", "<leader>fE", "<cmd>lua require('telescope.builtin').grep_string()<CR>", opts)

    --  Commands
    vim.keymap.set("n", "<leader>c", "<cmd>lua require('telescope.builtin').commands()<CR>", opts)
    vim.keymap.set("n", "<leader>C", "<cmd>lua require('telescope.builtin').command_history()<CR>", opts)

    -- search
    vim.keymap.set("n", "<leader>/", "<cmd>lua require('telescope.builtin').search_history()<CR>", opts)

    -- Git
    vim.keymap.set("n", "<leader>gs", "<cmd>lua require('telescope.builtin').git_status()<CR>", opts)
    vim.keymap.set("n", "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>", opts)
    vim.keymap.set("n", "<leader>gC", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", opts)
    vim.keymap.set("n", "<leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<CR>", opts)

    -- Debug
    vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
    vim.keymap.set("n", "<leader>dB",
        "<cmd>lua require'dap'.list_breakpoints()<CR><cmd>lua require('telescope.builtin').quickfix()<CR>", opts)
    vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.continue()<CR>", opts)
    vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<CR>", opts)
    vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts)
    vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.restart()<CR>", opts)
    vim.keymap.set("n", "<leader>du", "<cmd>lua require'dap'.up()<CR>", opts)
    vim.keymap.set("n", "<leader>dU", "<cmd>lua require'dap'.up()<CR>", opts)
    vim.keymap.set("n", "<leader>dp", "<cmd>lua require'dapui'.eval()<CR>", opts)
    vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>", opts)
    vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opts)
    vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>", opts)
end

local keymap_opts = { noremap = true, silent = true }
function G.setup_buf_lsp_keymaps(bufnr, server_capabilities)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>rf", "<cmd>lua vim.lsp.buf.code_action()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>fs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>fS", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>fq", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>jd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", keymap_opts)
    buf_set_keymap("n", "<leader>jt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>()", keymap_opts)

    -- Set some keybinds conditional on server capabilities
    if server_capabilities.documentFormattingProvider then
        buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.format()<CR>", keymap_opts)
    end
end

function G.setup_toggle_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('n', '<esc>', "<cmd>ToggleTerm<CR>", opts)
end

local cmp = require('cmp')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
G.completion_keymaps = {
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()   -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
            cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
        end
    end, { "i", "s" }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,   -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
}

local tel_actions = require("telescope.actions")
G.telescope_keymaps = {
    n = {
        ['<C-d>'] = require('telescope.actions').delete_buffer
    },
    i = {
        ["<C-c>"] = false,
        ["<esc>"] = tel_actions.close,
        ['<C-d>'] = require('telescope.actions').delete_buffer
    }
}

return G
