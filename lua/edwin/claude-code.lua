-- Claude Code configuration
require('claude-code').setup({
  -- Window configuration
  window = {
    height = 15,  -- Terminal window height
    position = 'botright',
  },
  
  -- File refresh settings
  auto_refresh = true,  -- Auto-refresh files modified by Claude Code
  
  -- Git project detection
  use_git_root = true,  -- Use git root as working directory
  
  -- Keymaps (similar to your previous Augment setup)
  keymaps = {
    toggle = {
      normal = '<C-,>'
    },
    continue = {
      normal = '<leader>cc'
    },
    verbose = {
      normal = '<leader>cv'
    },
    new_chat = {
      normal = '<leader>cn'
    },
  },
  
  -- Shell preferences
  shell = {
    cmd = 'zsh',
    separator = ';'
  },
  
  -- Claude Code CLI arguments
  claude_args = {
    -- Add any default arguments you want to pass to Claude Code
    -- For example: '--model', 'claude-3-sonnet-20240229'
  },
})