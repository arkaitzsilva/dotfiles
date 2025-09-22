require("full-border"):setup {
  type = ui.Border.ROUNDED,
}

th.git = th.git or {}
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.ignored_sign = "I"
th.git.deleted_sign = "D"
th.git.updated_sign = "U"
require("git"):setup()

require("recycle-bin"):setup({
  -- Optional: Override automatic trash directory discovery
  -- trash_dir = "~/.local/share/Trash/",  -- Uncomment to use specific directory
})
