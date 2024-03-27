local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

keymap.set("v", "c", '"+y', { noremap = true }) -- Copy to clipboard
-- Ctrl+V pastes

keymap.set('n', 'z', '<C-g>u<Cmd>u<CR>', { noremap = true }) --Undo
keymap.set('n', 'y', '<Esc><C-r>', { noremap = true }) -- Redo (Could replace with <C-o><C-r>)


keymap.set('n', 'k', 'ge', { noremap = true }) -- Goes to end of previous word
keymap.set('n', 'l', 'a<C-Right><Esc>', {noremap=true}) -- Goes to beginning of next word

keymap.set('n', 'd', '<Cmd>t.<CR>k', {noremap=true}) -- Duplicate line without moving cursor

keymap.set('n', 'q', '<Cmd>qa<CR>', {noremap=true}) -- Quit without saving

keymap.set('n', 'w', '<Cmd>:bd<CR>', {noremap=true}) -- Quit without saving

keymap.set('n', 's', '<Cmd>w<CR>', {noremap=true}) -- Save

keymap.set('v', '<BS>', '"_d', { noremap = true }) -- Backspace removes selection

keymap.set('v', '<Left>', 'ge', { noremap = true })
keymap.set('v', '<Right>', '<C-S-Right>', { noremap = true })

keymap.set("v", "x", '"+y<C-o>vgvxi', { noremap = true }) -- Cut selection

keymap.set('i', '<C-e>', '<C-o>:', {noremap=true}) -- Makes it easier to get to commands

keymap.set({'n','v'}, 'e', '$', {noremap=true}) -- Go to end of line

keymap.set({'n','v'}, 'b', '0', {noremap=true}) -- Go to beginning of line

keymap.set("i", "<Esc>", "<Esc>l", {noremap=true})
