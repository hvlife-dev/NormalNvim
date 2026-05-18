return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended to pin to version 5
    lazy = false,
    ft = "rust",
    init = function()
      vim.g.rustaceanvim = function()
        -- Fetch capabilities from NormalNvim's default cmp setup
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if status then
          capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

        return {
          tools = {
            enable_clippy = true,
          },
          server = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              local opts = { silent = true, buffer = bufnr }
              vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp('codeAction') end, opts)
              vim.keymap.set("n", "K", function() vim.cmd.RustLsp({"hover", "actions"}) end, opts)
            end,
            default_settings = {
              ['rust-analyzer'] = {
                cargo = {
                  allFeatures = true,
                  buildScripts = {
                    enable = true,
                  },
                },
                checkOnSave = true,
                check = {
                  command = "clippy",
                  extraArgs = { "--no-deps" },
                },
              },
            },
          },
        }
      end
    end,
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst';
    -- lazy = false, -- or ft = 'typst'
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_maps = {
        ["Add Cursor Down"] = "<A-Down>",
        ["Add Cursor Up"]   = "<A-Up>",
      }
    end,
  },
  {
    "sbatin/platformio.nvim",
    dependencies = { "numToStr/FTerm.nvim" },
  },
  {
    'LhKipp/nvim-nu',
    -- build = ':TSInstall nu',
    opts = {}
  },
  {
    'salkin-mada/openscad.nvim',
    config = function()
        vim.g.openscad_load_snippets = true
        require('openscad')
    end,
    dependencies = {
        'ibhagwan/fzf-lua',
    },
  }

}
