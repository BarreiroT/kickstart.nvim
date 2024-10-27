local notes_directory = vim.fn.expand '~/notes/'

local function get_note_name()
  local handle = io.popen 'git rev-parse --abbrev-ref HEAD 2>/dev/null'

  if handle == nil then
    return 'notes'
  end

  local branch_name = handle:read '*l'
  handle:close()
  return branch_name:gsub('/', '_') or 'notes'
end

local function get_current_directory_name()
  local full_path = vim.fn.getcwd()

  return vim.fn.fnamemodify(full_path, ':t')
end

local function open_or_create_branch_note()
  local note_name = get_note_name()

  local current_dir_name = get_current_directory_name()

  if not current_dir_name then
    print 'Unable to determine current directory name.'
    return
  end

  local note_path = notes_directory .. current_dir_name .. '/' .. note_name .. '.md'

  vim.fn.mkdir(notes_directory .. current_dir_name, 'p')

  -- Check if the note panel buffer already exists
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == note_path then
      -- If the buffer is already open, switch to the window showing it
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
    end
  end

  vim.cmd 'vsplit'
  vim.cmd 'wincmd L'
  vim.cmd 'vertical resize 30'

  local file = io.open(note_path, 'r')
  if file then
    file:close()
  else
    file = io.open(note_path, 'w')

    if file == nil then
      print 'Unable to open new note file'
      return
    end

    file:write('# ' .. note_name .. ' Notes\n\n')
    file:close()
  end

  vim.cmd('edit ' .. note_path)
end

local function open_notes_sidebar()
  local current_dir_name = get_current_directory_name()
  local target_dir = notes_directory .. current_dir_name

  vim.fn.mkdir(target_dir, 'p')

  vim.cmd 'vsplit'
  vim.cmd 'wincmd L'
  vim.cmd 'vertical resize 30'

  vim.cmd('Explore ' .. target_dir)
end

return {
  open_notes_sidebar = open_notes_sidebar,
  open_or_create_branch_note = open_or_create_branch_note,
}
