return {
  -- "hoangtan-dev/pi.nvim",
  dir = "/home/deval/repos/personal/pi.nvim",
  name = "pi.nvim",
  lazy = false,
  dependencies = {
    {
      "folke/snacks.nvim",
      opts = {
        input = { enabled = true },
      },
    },
  },
  opts = {
    set_default_keymaps = false,
  },
  config = function(_, opts)
    local pi = require("pi-nvim")
    pi.setup(opts)

    vim.keymap.set("n", "<leader>pa", pi.prompt, { desc = "Pi: ask" })
    vim.keymap.set("v", "<leader>pa", pi.send_selection, { desc = "Pi: ask selection" })
    vim.keymap.set("n", "<leader>pf", pi.send_file, { desc = "Pi: send file" })
    vim.keymap.set("n", "<leader>pb", pi.send_buffer, { desc = "Pi: send buffer" })
    vim.keymap.set("n", "<leader>ps", pi.sessions, { desc = "Pi: select session" })
    vim.keymap.set("n", "<leader>pm", "<cmd>PiSelectMessage<cr>", { desc = "Pi: select message" })
    vim.keymap.set("n", "<leader>pc", "<cmd>PiChanges<cr>", { desc = "Pi: changes" })
    vim.keymap.set("n", "<leader>pi", pi.ping, { desc = "Pi: ping" })
  end,
}
