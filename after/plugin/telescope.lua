local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local state = require('telescope.actions.state')

-- Setup telescope
require('telescope').setup({})

-- Custom picker to add files to Aider
local function aider_add_files()
  pickers.new({}, {
    prompt_title = "Add Files to Aider",
    finder = finders.new_oneshot_job({"git", "ls-files"}, {}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          local filename = selection[1]
          -- Find aider terminal buffer
          local aider_buf = nil
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name:match("term://.*aider") then
              aider_buf = buf
              break
            end
          end
          
          if aider_buf then
            -- Send /add command to aider terminal
            vim.api.nvim_chan_send(vim.api.nvim_buf_get_var(aider_buf, "terminal_job_id"), "/add " .. filename .. "\n")
            vim.notify("Added " .. filename .. " to aider", vim.log.levels.INFO)
          else
            vim.notify("Aider terminal not found. Please open aider first with <leader>ao", vim.log.levels.WARN)
          end
        end
      end)
      return true
    end,
  }):find()
end

vim.keymap.set('n', '<leader>e', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>?', builtin.help_tags, {})
vim.keymap.set('n', '<leader>m', builtin.man_pages, {})
vim.keymap.set('n', '<F1>', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>r', builtin.registers, {})
vim.keymap.set('n', '<leader>k', builtin.keymaps, {})
vim.keymap.set('n', '<leader>t', builtin.treesitter, {})
vim.keymap.set('n', '<leader>af', aider_add_files, { desc = "Add files to Aider" })
