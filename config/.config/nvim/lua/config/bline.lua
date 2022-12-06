local bline = require('bufferline')

-- for i = 1, 9 do
--   nnoremap("<leader>" .. i, function()
--     bline.go_to_buffer(i, true)
--   end)
-- end
-- nnoremap("<leader>" .. 0, function()
--   bline.go_to_buffer(-1, true)
-- end)

bline.setup({
  options = {
    offsets = {
        {
            filetype = "NvimTree",
            -- text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
        },
    },
    indicator = {
        icon = "▎",
        style = 'icon'
    },
    modified_icon = "●",
    buffer_close_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    numbers = "ordinal",
    tab_size = 20,
    max_name_length = 20,
    max_prefix_length = 6,
    diagnostics = "nvim_lsp",
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    persist_buffer_sort = true,
    enforce_regular_tabs = true,
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and "" or ""
        return icon .. count
    end,
  },
})
