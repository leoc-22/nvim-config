return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinLeave" },
  config = function()
    require("colorful-winsep").setup({
      border = "bold",
      animate = {
        enabled = false, -- false to disable, or choose a option below (e.g. "shift") and set option for it if needed
      },
    })
  end,
}
