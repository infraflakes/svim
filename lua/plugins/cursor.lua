return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  lazy = false, -- MUST be false so it overrides native 'c' operator on boot!
  config = function()
    local mc = require "multicursor-nvim"

    mc.setup()

    local set = vim.keymap.set

    -- Hijack 'c' to spawn cursor down (nowait overrides operator-pending)
    set({ "n", "v" }, "c", function()
      mc.lineAddCursor(1)
    end, { nowait = true, desc = "Add cursor down" })

    -- Hijack 'C' to spawn cursor up
    set({ "n", "v" }, "C", function()
      mc.lineAddCursor(-1)
    end, { nowait = true, desc = "Add cursor up" })

    -- Easy exit back to single cursor
    set("n", "<Esc>", function()
      if mc.hasCursors() then
        mc.clearCursors()
      else
        vim.cmd "noh"
      end
    end)
  end,
}
