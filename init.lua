local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.number = true
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
	    "git",
	    "clone",
	    "--filter=blob:none",
	    "https://github.com/folke/lazy.nvim.git", 
	    "--branch=stable", 
	    lazypath
    })
end
vim.opt.rtp:prepend(lazypath)
vim.api.nvim_set_keymap('x', '<Tab>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<S-Tab>', '<gv', { noremap = true, silent = true })

local plugins = {
    {
        "sheerun/vim-polyglot",
        config = function()
            vim.g.polyglot_disabled = {"sensible"}
        end,
    },
        -- nvim-tree.lua
    {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                },
            })
        end,
    },
   

    -- Status Line
    {

        "hoob3rt/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "gruvbox",
                    section_separators = {"", ""},
                    component_separators = {"", ""},
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {"branch"},
                    lualine_c = {"filename"},
                    lualine_x = {"encoding", "fileformat", "filetype"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"},
                },
                extensions = {"fugitive", "nvim-tree"},
            })
        end,
    },

    -- Auto-pairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Auto-detect Indentation
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.g.indent_blankline_enabled = true
            vim.g.indent_blankline_char = "│"
            vim.g.indent_blankline_space_char = " "
            vim.g.indent_blankline_space_char_blankline = " "
        end,
    },



    -- Buffer Line
    {
        "akinsho/nvim-bufferline.lua",
        config = function()
            require("bufferline").setup({})
        end,
    },

    {
        "nvim-lua/plenary.nvim",
        config = function()
        end,
    },

 
    -- Telescope (for fuzzy finding and better navigation)
    -- nvim-telescope/telescope.nvim
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            {"nvim-lua/popup.nvim"},
            {"nvim-lua/plenary.nvim"},
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    prompt_prefix = "🔍 ",
                    selection_caret = "❯ ",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            mirror = false,
                        },
                        vertical = {
                            mirror = false,
                        },
                    },
                    file_sorter = require("telescope.sorters").get_fzy_sorter,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                },
            })
        end,
    },
       
    -- Auto-completion
    {
        "hrsh7th/nvim-cmp",
        requires = {
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-nvim-lua"},
            {"hrsh7th/cmp-buffer"},
            {"saadparwaiz1/cmp_luasnip"},
            {"L3MON4D3/LuaSnip"},
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "luasnip" },
                },
            })
        end,
    },
}

-- Install and configure your plugins
require("lazy").setup(plugins, {
    -- Optional configuration
    log_level = "warn",
    auto_resize = true,
})

require("lazy").setup(plugins, opts)
