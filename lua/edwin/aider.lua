-- Aider.nvim configuration and keybindings
-- Aider is an AI pair programming tool for your terminal

local status_ok, aider = pcall(require, "aider")
if not status_ok then
  return
end

-- Configure aider
aider.setup({
  auto_manage_context = true,
  default_bindings = false, -- Disable default bindings to set custom ones
})

-- Keybindings for Aider as per plugin documentation
vim.keymap.set("n", "<leader>ao", "<cmd>AiderOpen<cr>", { desc = "Open Aider" })
vim.keymap.set("n", "<leader>am", "<cmd>AiderAddModifiedFiles<cr>", { desc = "Add modified files to Aider" })
-- Note: Use <leader>af to add files to Aider via Telescope
