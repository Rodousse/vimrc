local G = {}

function G.setup_linter()
  require('lint').linters_by_ft = {
    cpp = {'cppcheck', 'clang-tidy'}
  }
  vim.cmd("au BufWritePost <buffer> lua require('lint').try_lint()")
  vim.cmd("au BufEnter <buffer> lua require('lint').try_lint()")
end

return G
