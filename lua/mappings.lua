local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

keymap.set("v", "<C-c>", '"+y', { noremap = true }) -- Copy to clipboard
-- Ctrl+V pastes

keymap.set('i', '<C-z>', '<C-g>u<Cmd>u<CR>', { noremap = true }) --Undo
keymap.set('i', '<C-y>', '<Esc><C-r>i', { noremap = true }) -- Redo

-- Ctrl+Right goes to beginning of next word
keymap.set('i', '<C-Left>', '<Esc>gea', { noremap = true }) -- Goes to end of previous word

keymap.set('i', '<C-d>', '<Cmd>t.<CR><Esc>ka', {noremap=true}) -- Duplicate line without moving cursor

keymap.set('i', '<C-q>', '<Cmd>qa<CR>', {noremap=true}) -- Quit without saving

keymap.set('i', '<C-w>', '<Cmd>:bd<CR>', {noremap=true}) -- Quit without saving

keymap.set('i', '<C-s>', '<Cmd>w<CR>', {noremap=true}) -- Save

keymap.set('v', '<BS>', '"_d', { noremap = true }) -- Backspace removes selection

keymap.set('i', '<C-S-Right>', '<C-o>v<C-Right>', {noremap=true})
keymap.set('i', '<C-S-Left>', '<C-o>v<C-Left>', {noremap=true})
keymap.set('v', '<C-S-Left>', 'gel', { noremap = true })

keymap.set("v", "<C-x>", '"+y<C-o>vgvxi', { noremap = true }) -- Cut selection

keymap.set('i', '<C-e>', '<C-o>:', {noremap=true}) -- 