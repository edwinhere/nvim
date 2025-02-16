-- Initialize yarepl
local yarepl = require('yarepl')

-- Function to get list of open files
local function get_open_files()
  local buffers = vim.api.nvim_list_bufs()
  local files = {}
  for _, bufnr in ipairs(buffers) do
    -- Skip REPL buffers and special buffers
    local name = vim.api.nvim_buf_get_name(bufnr)
    local should_include = vim.api.nvim_buf_is_loaded(bufnr)
      and name ~= ""  -- not empty
      and not name:match("^#") -- not starting with #
      and not name:match("^term://") -- not a terminal
      and not name:match("REPL$") -- not a REPL buffer
      and vim.bo[bufnr].buftype == "" -- regular file buffer

    if should_include then
      table.insert(files, name)
    end
  end
  return files
end

-- Function to get list of open terminal buffers
local function get_open_terminals()
  local buffers = vim.api.nvim_list_bufs()
  local terminals = {}
  for _, bufnr in ipairs(buffers) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    local should_include = vim.api.nvim_buf_is_loaded(bufnr)
      and name:match("^term://") -- is a terminal
      and not name:match("REPL$") -- not a REPL buffer

    if should_include then
      table.insert(terminals, name)
    end
  end
  return terminals
end

-- Function to add files to aider
local function add_open_files_to_aider()
  -- Try to find existing aider REPL first
  local repl_exists = false
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name:match("aider$") then
      repl_exists = true
      break
    end
  end

  if not repl_exists then
    vim.cmd('REPLStart aider')
    vim.cmd('sleep 500m') -- Wait for REPL to start
  end

  -- Get list of files and send them to aider
  local files = get_open_files()
  for _, file in ipairs(files) do
    -- Use REPLExec to send commands to the REPL
    vim.cmd(string.format('REPLExec $aider /add %s', file))
    vim.cmd('sleep 100m') -- Small delay between adds
  end
end

-- Function to add terminals to aider
local function add_terminals_to_aider()
  -- Try to find existing aider REPL first
  local repl_exists = false
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name:match("aider$") then
      repl_exists = true
      break
    end
  end

  if not repl_exists then
    vim.cmd('REPLStart aider')
    vim.cmd('sleep 500m') -- Wait for REPL to start
  end

  -- Get list of terminals and send them to aider
  local terminals = get_open_terminals()
  for _, term in ipairs(terminals) do
    -- Use REPLExec to send commands to the REPL
    vim.cmd(string.format('REPLExec $aider /add %s', term))
    vim.cmd('sleep 100m') -- Small delay between adds
  end
end

-- Function to add rg --files results to aider
local function add_rg_files_to_aider()
    -- Get list of files from rg --files
    local files = vim.fn.systemlist('rg --files')
    if vim.v.shell_error ~= 0 then
        vim.notify("Error running rg --files", vim.log.levels.ERROR)
        return
    end

    -- Try to find existing aider REPL first
    local repl_exists = false
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match("aider$") then
            repl_exists = true
            break
        end
    end

    if not repl_exists then
        vim.cmd('REPLStart aider')
        vim.cmd('sleep 500m') -- Wait for REPL to start
    end

    -- Send files to aider
    for _, file in ipairs(files) do
        vim.cmd(string.format('REPLExec $aider /add %s', file))
        vim.cmd('sleep 50m') -- Tiny delay between adds
    end
end

-- Function to add current file to aider
local function add_current_file_to_aider()
    -- Get current file first
    local current_file = vim.api.nvim_buf_get_name(0)
    -- Check if current buffer is a valid file (not REPL/terminal/special buffer)
    local should_include = current_file ~= ""  -- not empty
        and not current_file:match("^#") -- not starting with #
        and not current_file:match("^term://") -- not a terminal
        and not current_file:match("REPL$") -- not a REPL buffer
        and vim.bo[0].buftype == "" -- regular file buffer

    if not should_include then
        return
    end

    -- Try to find existing aider REPL
    local repl_exists = false
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match("aider$") then
            repl_exists = true
            break
        end
    end

    if not repl_exists then
        vim.cmd('REPLStart aider')
        vim.cmd('sleep 500m') -- Wait for REPL to start
    end

    vim.cmd(string.format('REPLExec $aider /add %s', current_file))
end

-- Change this so that when sending visual selection to aider, the user can type something after the visual selection is sent to the REPL
-- Function to send visual selection to aider
local function send_visual_to_aider()
    -- Try to find existing aider REPL first
    local repl_exists = false
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match("aider$") then
            repl_exists = true
            break
        end
    end

    if not repl_exists then
        vim.cmd('REPLStart aider')
        vim.cmd('sleep 500m') -- Wait for REPL to start
    end

    -- Use REPLSendVisual to send the selection
    vim.cmd('REPLSendVisual aider')
end

-- Function to send last neovim message to aider
local function send_last_message_to_aider()
    local messages = vim.split(vim.fn.execute('messages'), '\n')
    local last_message = ''
    
    -- Find the last non-empty message (skip empty lines at end)
    for i = #messages, 1, -1 do
        if messages[i] and messages[i]:gsub('%s+', '') ~= '' then
            last_message = messages[i]
            break
        end
    end

    if last_message == '' then
        vim.notify("No messages found", vim.log.levels.WARN)
        return
    end

    -- Ensure aider REPL exists
    local repl_exists = false
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match("aider$") then
            repl_exists = true
            break
        end
    end

    if not repl_exists then
        vim.cmd('REPLStart aider')
        vim.cmd('sleep 500m') -- Wait for REPL to start
    end

    -- Send the message with a prefix to indicate it's from neovim messages
    vim.cmd(string.format('REPLExec $aider -- The last neovim message was: %s', last_message))
end

-- Add visual mode mapping for sending to aider
vim.keymap.set('v', '<leader>as', send_visual_to_aider, { silent = true, desc = "Send visual selection to aider" })

-- Keybinding to start aider REPL
vim.keymap.set('n', '<leader>ai', ':REPLStart aider<CR>', { silent = true, desc = "Start aider REPL" })

-- Keybinding to add current file to aider
vim.keymap.set('n', '<leader>ac', add_current_file_to_aider, { silent = true, desc = "Add current file to aider" })

-- Keybinding to add all open files to aider
vim.keymap.set('n', '<leader>aa', add_open_files_to_aider, { silent = true, desc = "Add open files to aider" })

-- Keybinding to add all terminals to aider
vim.keymap.set('n', '<leader>at', add_terminals_to_aider, { silent = true, desc = "Add terminal buffers to aider" })

-- Keybinding to start aider REPL
vim.keymap.set('n', '<F5>', ':REPLHideOrFocus aider<CR>', { silent = true, desc = "Toggle aider REPL" })

-- Keybinding to add rg --files results to aider
vim.keymap.set('n', '<leader>ar', add_rg_files_to_aider, { silent = true, desc = "Add rg --files results to aider" })

-- Keybinding to send last message to aider
vim.keymap.set('n', '<leader>am', send_last_message_to_aider, { silent = true, desc = "Send last message to aider" })

-- Function to add telescope grep results to aider
local function add_telescope_grep_results_to_aider()
    local action_state = require('telescope.actions.state')
    local actions = require('telescope.actions')
    
    -- Get the current picker and prompt buffer
    local current_picker = action_state.get_current_picker()
    if not current_picker then
        vim.notify("No active telescope picker", vim.log.levels.ERROR)
        return
    end

    -- Get the current entry directly
    local entry = action_state.get_selected_entry()
    if not entry then
        vim.notify("No file selected", vim.log.levels.WARN)
        return
    end

    -- Try to find existing aider REPL first
    local repl_exists = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match("aider$") then
            repl_exists = true
            break
        end
    end

    if not repl_exists then
        vim.cmd('REPLStart aider')
        vim.cmd('sleep 500m') -- Wait for REPL to start
    end

    -- Send file to aider
    local filename = entry.filename or entry[1]
    if filename then
        vim.cmd(string.format('REPLExec $aider /add %s', filename))
    end

    -- Close telescope using the prompt_bufnr from the current picker
    actions.close(current_picker.prompt_bufnr)
end

-- Return the module with functions exposed
return {
    add_telescope_grep_results_to_aider = add_telescope_grep_results_to_aider
}
