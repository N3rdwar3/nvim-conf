-- ~/.config/nvim/lua/carson/fs_ticket.lua
local function fs_ticket(ticket)
  return ("https://support.devrygreenhouses.com/a/tickets/%s"):format(ticket)
end

-- Expose as a global so :lua and insert-mode expressions can reach it
_G.fs_ticket = fs_ticket

-- 1. Insert URL at cursor via Command: :FsTicket 123
vim.api.nvim_create_user_command("FsTicket", function(opts)
  vim.api.nvim_put({ fs_ticket(opts.args) }, "c", true, true)
end, { nargs = 1 })

-- 2. Function to automatically grab cword and replace it
local function replace_ticket_number_with_url()
  local word = vim.fn.expand("<cword>")
  -- Ensure there is actually a word under the cursor
  if word ~= "" then
    vim.cmd("normal! diw") 
    vim.api.nvim_put({ fs_ticket(word) }, "c", false, true)
  end
end

-- 3. Map a shortcut (e.g., <leader>tk) to trigger the substitution in Normal Mode
vim.keymap.set("n", "<leader>fst", replace_ticket_number_with_url, { 
  desc = "Replace word under cursor with Freshdesk ticket URL" 
})

return { 
  url = fs_ticket,
  replace_word = replace_ticket_number_with_url
}

