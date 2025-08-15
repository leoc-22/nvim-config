return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()
    -- Enable virtual text to show inline error messages
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = true
    })
  end
}
