return {
  "RRethy/base16-nvim",
  config = function()
    local ok, matugen = pcall(require, "matugen")
    if ok then
      matugen.setup()
    end

    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = "Keyword", default = false })
    vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { link = "Special", default = false })
    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { link = "Number", default = false })
    vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { link = "String", default = false })

    vim.api.nvim_set_hl(0, "DashboardHeader", { link = "Keyword", default = false })
    vim.api.nvim_set_hl(0, "DashboardIcon", { link = "Special", default = false })
    vim.api.nvim_set_hl(0, "DashboardKey", { link = "Number", default = false })
    vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { link = "Comment", default = false })
    vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { link = "Number", default = false })
  end,
}
