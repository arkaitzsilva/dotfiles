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

require("restore"):setup({
  -- Set the position for confirm and overwrite prompts.
  -- Don't forget to set height: `h = xx`
  -- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
  position = { "center", w = 70, h = 40 }, -- Optional

  -- Show confirm prompt before restore.
  -- NOTE: even if set this to false, overwrite prompt still pop up
  show_confirm = true,  -- Optional
})
