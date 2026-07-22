local Plugins = require("utils.plugins")

-- Mappings for Neo-tree
Plugins.configureSettings("neo-tree", {
  popup_border_style = "rounded",
  default_component_configs = {
    git_status = {
      symbols = {
        -- Change type
        added = "✚", -- or "✚"
        modified = "", -- or ""
        deleted = "✖", -- this can only be used in the git_status source
        renamed = "󰁕", -- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  source_selector = {
    winbar = true,
  },
  window = {
    mappings = {
      -- ["<C-s>"] = {
      --   "quick_jump",
      --   config = {
      --     -- This will automaticly open / toggle the target node after jumping.
      --     -- You can set it to `nil` to perform only the jump action,
      --     -- or write your own callback (---@type fun(state, node)).
      --     on_jump = "open_or_toggle",
      --     jump_labels = "jfkdlsahgnuvrbytmiceoxwpqz",
      --   }
      -- },
      -- ["<Tab>"] = "select",
      -- ["<C-;>"] = "clear_selection",
      ["<space>"] = "noop",
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel", -- close preview or floating neo-tree window
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = true,
          use_snacks_image = true,
          use_image_nvim = true,
        },
      },
      -- Read `# Preview Mode` for more information
      ["l"] = "noop",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["C"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      --["Z"] = "expand_all_subnodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["b"] = "rename_basename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["<C-r>"] = "clear_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<S-h>"] = "prev_source",
      ["<S-l>"] = "next_source",
      ["i"] = "show_file_details",
      -- ["i"] = {
      --   "show_file_details",
      --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
      --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
      --   -- config = {
      --   --   created_format = "%Y-%m-%d %I:%M %p",
      --   --   modified_format = "relative", -- equivalent to the line below
      --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
      --   -- }
      -- },
    },
  },
  filesystem = {
    hijack_netrw_behavior = "open_current",
    window = {
      mappings = {
        ["<leader>h"] = { "toggle_hidden", desc = "Toggle hidden files" },
        ["H"] = "noop",
        ["/"] = "fuzzy_finder",
        --["/"] = {"fuzzy_finder", config = { keep_filter_on_submit = true }},
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ["D"] = "fuzzy_finder_directory",
        -- ["D"] = "fuzzy_sorter_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
        ["b"] = "rename_basename",
        ["o"] = { "open", nowait = true },
        ["oc"] = "noop",
        ["od"] = "noop",
        ["og"] = "noop",
        ["om"] = "noop",
        ["on"] = "noop",
        ["os"] = "noop",
        ["ot"] = "noop",
        ["<leader>oc"] = { "order_by_created", nowait = false },
        ["<leader>od"] = { "order_by_diagnostics", nowait = false },
        ["<leader>og"] = { "order_by_git_status", nowait = false },
        ["<leader>om"] = { "order_by_modified", nowait = false },
        ["<leader>on"] = { "order_by_name", nowait = false },
        ["<leader>os"] = { "order_by_size", nowait = false },
        ["<leader>ot"] = { "order_by_type", nowait = false },
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
        ["<Esc>"] = "close",
        ["<S-CR>"] = "close_keep_filter",
        ["<C-CR>"] = "close_clear_filter",
        ["<C-w>"] = { "<C-S-w>", raw = true },
        {
          -- normal mode mappings
          n = {
            ["j"] = "move_cursor_down",
            ["k"] = "move_cursor_up",
            ["<S-CR>"] = "close_keep_filter",
            ["<C-CR>"] = "close_clear_filter",
            ["<esc>"] = "close",
          }
        }
        -- ["<esc>"] = "noop", -- if you want to use normal mode
        -- ["key"] = function(state, scroll_padding) ... end,
      },
    },
  },
  buffers = {
    window = {
      mappings = {
        ["d"] = "buffer_delete",
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["o"] = { "open", nowait = true },
        ["oc"] = "noop",
        ["od"] = "noop",
        ["og"] = "noop",
        ["om"] = "noop",
        ["on"] = "noop",
        ["os"] = "noop",
        ["ot"] = "noop",
        ["<leader>oc"] = { "order_by_created", nowait = false },
        ["<leader>od"] = { "order_by_diagnostics", nowait = false },
        ["<leader>om"] = { "order_by_modified", nowait = false },
        ["<leader>on"] = { "order_by_name", nowait = false },
        ["<leader>os"] = { "order_by_size", nowait = false },
        ["<leader>ot"] = { "order_by_type", nowait = false },
      },
    },
  },
  git_status = {
    window = {
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "noop",
        ["gU"] = "noop",
        ["ga"] = "noop",
        ["gt"] = "noop",
        ["gr"] = "noop",
        ["gc"] = "noop",
        ["gp"] = "noop",
        ["gl"] = "noop",
        ["gg"] = "noop",
        -- ["<leader>gu"] = "git_unstage_file",
        -- ["<leader>gU"] = "git_undo_last_commit",
        -- ["<leader>ga"] = "git_add_file",
        -- ["<leader>gt"] = "git_toggle_file_stage",
        -- ["<leader>gr"] = "git_revert_file",
        -- ["<leader>gc"] = "git_commit",
        -- ["<leader>gp"] = "git_push",
        -- ["<leader>gl"] = "git_pull",
        -- ["<leader>gg"] = "git_commit_and_push",
        ["o"] = { "open", nowait = true },
        ["oc"] = "noop",
        ["od"] = "noop",
        ["og"] = "noop",
        ["om"] = "noop",
        ["on"] = "noop",
        ["os"] = "noop",
        ["ot"] = "noop",
        ["<leader>oc"] = { "order_by_created", nowait = false },
        ["<leader>od"] = { "order_by_diagnostics", nowait = false },
        ["<leader>om"] = { "order_by_modified", nowait = false },
        ["<leader>on"] = { "order_by_name", nowait = false },
        ["<leader>os"] = { "order_by_size", nowait = false },
        ["<leader>ot"] = { "order_by_type", nowait = false },
      },
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        vim.cmd(":Neotree show")
      end,
    },
  },
})


Plugins.configureKeymaps("neo-tree", {
  {
    mode = "n",
    lhs = "<leader>e",
    rhs = "<cmd>Neotree toggle<cr>",
    opts = { noremap = true, silent = true },
    desc = "Toggle Neo-tree",
  },
  {
    mode = "n",
    lhs = "<leader>fe",
    rhs = "<cmd>Neotree focus<cr>",
    opts = { noremap = true, silent = true },
    desc = "Focus Neo-tree",
  },
  {
    mode = "n",
    lhs = "<leader>be",
    rhs = "<cmd>Neotree buffers<cr>",
    opts = { noremap = true, silent = true },
    desc = "Neo-tree Buffers",
  },
  {
    mode = "n",
    lhs = "<leader>ge",
    rhs = "<cmd>Neotree git_status<cr>",
    opts = { noremap = true, silent = true },
    desc = "Neo-tree Git Status",
  },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- require("neo-tree").setup({
--   filesystem = {
--     hijack_netrw_behavior = "open_current",
--   },
-- })


-- local first_time_only = true
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local buf = vim.api.nvim_get_current_buf()
--     local filetype = vim.bo[buf].filetype
--
--     -- Check if the nvim arg is a directory
--     if vim.fn.argc() == 0 or vim.fn.isdirectory(vim.fn.argv(0)) == 0 then
--       return
--     end
--     if filetype ~= "neo-tree" and vim.fn.isdirectory(vim.fn.expand("%:p")) == 0 and first_time_only then
--       first_time_only = false
--       local has_neo = false
--
--       for _, win in ipairs(vim.api.nvim_list_wins()) do
--         local b = vim.api.nvim_win_get_buf(win)
--         if vim.bo[b].filetype == "neo-tree" then
--           has_neo = true
--           break
--         end
--       end
--
--       if not has_neo then
--         require("neo-tree.command").execute({
--           source = "filesystem",
--           position = "left",
--           reveal = true,
--           dir = vim.fn.getcwd(),
--         })
--         -- Focus the buffer window after opening Neo-tree
--         vim.cmd("wincmd p")
--       end
--     end
--   end,
-- })
