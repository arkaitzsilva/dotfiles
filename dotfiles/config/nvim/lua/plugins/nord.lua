return {
  'arcticicestudio/nord-vim', 
  name = 'nord', 
  priority = 1000,
  config = function()
    -- Load the colorscheme here.
    vim.cmd.colorscheme 'nord'
  end
}
