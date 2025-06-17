-- Augment.vim configuration
-- Configure workspace folders to help Augment understand your codebase better

-- Set workspace folders (adjust these paths to your actual project directories)
-- You can add multiple workspace folders by adding them to this list
-- Use absolute paths or paths relative to your home directory (~)
vim.g.augment_workspace_folders = {
  -- Add your project directories here, for example:
  -- '~/projects/my-project',
  -- '/path/to/another/project',
  
  -- For now, we'll add the current Neovim config as an example
  vim.fn.expand('~/.config/nvim'),
  vim.fn.expand('~/.local/share/nvim'),
}

-- Optional: Disable tab mapping if you prefer to use a different key
-- vim.g.augment_disable_tab_mapping = true

-- Optional: Disable completions entirely
-- vim.g.augment_disable_completions = true

-- Augment.vim keybindings (recommended from the official documentation)
-- Chat with Augment AI
vim.keymap.set('n', '<leader>ac', ':Augment chat<CR>', { silent = true, desc = "Augment chat" })
vim.keymap.set('v', '<leader>ac', ':Augment chat<CR>', { silent = true, desc = "Augment chat with selection" })

-- Start new chat conversation
vim.keymap.set('n', '<leader>an', ':Augment chat-new<CR>', { silent = true, desc = "Augment new chat" })

-- Toggle chat panel
vim.keymap.set('n', '<leader>at', ':Augment chat-toggle<CR>', { silent = true, desc = "Augment toggle chat" })

-- Additional useful Augment commands (you can add keybindings for these if desired)
-- :Augment status        - View the current status of the plugin
-- :Augment signin        - Start the sign in flow
-- :Augment signout       - Sign out of Augment
-- :Augment log           - View the plugin log
