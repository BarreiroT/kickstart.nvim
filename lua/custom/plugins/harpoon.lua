return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('harpoon'):setup {}
  end,
  keys = {
    {
      '<C-z>',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'harpoon file',
    },
    {
      '<C-c>',
      function()
        local conf = require('telescope.config').values
        local function toggle_telescope(harpoon_files)
          local function finder()
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
              table.insert(file_paths, item.value)
            end

            return require('telescope.finders').new_table {
              results = file_paths,
            }
          end

          require('telescope.pickers')
            .new({}, {
              prompt_title = 'Harpoon',
              finder = finder(),
              previewer = conf.file_previewer {},
              sorter = conf.generic_sorter {},
              attach_mappings = function(prompt_bufnr, map)
                map('i', '<C-d>', function()
                  local state = require 'telescope.actions.state'
                  local selected_entry = state.get_selected_entry()
                  local current_picker = state.get_current_picker(prompt_bufnr)

                  table.remove(harpoon_files.items, selected_entry.index)
                  current_picker:refresh(finder())
                end)
                return true
              end,
            })
            :find()
        end
        local harpoon = require 'harpoon'

        toggle_telescope(harpoon:list())
      end,
      desc = 'harpoon quick menu',
    },
    {
      '<C-s>',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'harpoon to file 1',
    },
    {
      '<C-d>',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'harpoon to file 2',
    },
    {
      '<C-1>',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'harpoon to file 3',
    },
    {
      '<C-2>',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'harpoon to file 4',
    },
    {
      '<C-3>',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'harpoon to file 5',
    },
  },
}
