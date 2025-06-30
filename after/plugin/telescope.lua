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
    prompt_title = "Add Files to Aider (Tab to select multiple, Enter to add)",
    finder = finders.new_oneshot_job({"git", "ls-files"}, {}),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local picker = state.get_current_picker(prompt_bufnr)
        local selections = picker:get_multi_selection()
        local current_selection = state.get_selected_entry()
        
        -- If no multi-selection, use current selection
        if #selections == 0 and current_selection then
          selections = {current_selection}
        end
        
        actions.close(prompt_bufnr)
        
        if #selections > 0 then
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
            local filenames = {}
            for _, selection in ipairs(selections) do
              table.insert(filenames, selection[1])
            end
            
            -- Send /add command with all selected files
            local add_command = "/add " .. table.concat(filenames, " ") .. "\n"
            vim.api.nvim_chan_send(vim.api.nvim_buf_get_var(aider_buf, "terminal_job_id"), add_command)
            vim.notify("Added " .. #filenames .. " file(s) to aider: " .. table.concat(filenames, ", "), vim.log.levels.INFO)
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
