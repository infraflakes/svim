vim.g.loaded_matchit = 1
vim.schedule(function()
  local builtin = require "telescope.builtin"
  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
  vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "[F]ind by [G]rep" })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
  vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent Files" })
end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", ";", ":", { desc = "Command Mode" })

vim.keymap.set("n", "<leader>ws", ":saveas ", { desc = "Write As (Save unnamed buffer)", silent = false })
vim.keymap.set("n", "<leader>wr", [[:%s///g<Left><Left><Left>]], { desc = "Substitute fast" })

-- Helix inspired

vim.keymap.set({ "n", "x" }, "%", "ggVG", { desc = "Select entire buffer" })

-- deletes visual selection, character under cursor, or empty line
vim.keymap.set({ "n", "x" }, "d", function()
  local mode = vim.api.nvim_get_mode().mode

  -- If in Visual mode, delete selection
  if mode:sub(1, 1) == "v" or mode == "V" or mode == "\22" then
    vim.cmd 'normal! "_d'
    return
  end

  -- If on an empty line in Normal mode, delete the entire line
  local line = vim.api.nvim_get_current_line()
  if line == "" then
    vim.cmd 'normal! "_dd'
  else
    -- Otherwise, delete single character under cursor
    vim.cmd 'normal! "_x'
  end
end, { desc = "Helix-style delete selection or character" })

vim.keymap.set({ "n", "v", "x" }, "U", "<C-r>", { noremap = true, desc = "Redo" })
vim.keymap.set({ "n", "x" }, "x", function()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "n" then
    vim.cmd "normal! V"
  else
    vim.cmd "normal! j"
  end
end, { desc = "Helix-style line selection" })

vim.keymap.set({ "n", "v", "x" }, "gh", "0", { desc = "Helix: Go to start of line" })
vim.keymap.set({ "n", "v", "x" }, "gl", "$", { desc = "Helix: Go to end of line" })
vim.keymap.set({ "n", "v", "x" }, "ge", "G", { desc = "Helix: Go to end of file" })

-- Jump between matching brackets, parentheses, or braces
vim.keymap.set({ "n", "v", "x" }, "m", "%", { desc = "Jump between matching brackets" })

-- Comment lines with space + c
vim.keymap.set({ "n", "v", "x" }, "<leader>c", "gcc", { remap = true, desc = "Comment toggle line" })
