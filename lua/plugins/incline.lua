return {
  {
    "b0o/incline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function(_, opts)
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")

      opts.window = {
        padding = 0,
        margin = { horizontal = 0 },
        zindex = 40,
      }
      opts.render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.") -- Show relative path
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        -- Ignore terminal buffer
        if string.match(filename, "^term://") then
          return nil
        end

        return {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
        }
      end

      return opts
    end,
  },
}
