return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,

    vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" }),

    config = function()
        require("oil").setup({
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return name == '..' or name == '.git'
                end,
            }
        })
    end,
}
