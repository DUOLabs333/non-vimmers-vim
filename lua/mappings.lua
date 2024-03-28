local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

keymap.set("v", "c", '"+y', { noremap = true }) -- Copy to clipboard
keymap.set("v", "v", 'P', { noremap = true }) -- Paste from clipboard


keymap.set('n', 'z', '<C-g>u<Cmd>u<CR>', { noremap = true }) --Undo
keymap.set('n', 'y', '<Esc><C-r>', { noremap = true }) -- Redo (Could replace with <C-o><C-r>)

keymap.set('n', 'c', 'Zl',{remap=true}) -- Activate spellcheck corrections

keymap.set('n', 'k', 'ge', { noremap = true }) -- Goes to end of previous word
keymap.set('n', 'l', 'a<C-Right><Esc>', {noremap=true}) -- Goes to beginning of next word

keymap.set('n', 'd', '<Cmd>t.<CR>k', {noremap=true}) -- Duplicate line without moving cursor

keymap.set('n', 'q', '<Cmd>qa<CR>', {noremap=true}) -- Quit without saving

keymap.set('n', 'w', '<Cmd>:bd<CR>', {noremap=true}) -- Quit without saving

keymap.set('n', 's', '<Cmd>w<CR>', {noremap=true}) -- Save

keymap.set('v', '<BS>', '"_d', { noremap = true }) -- Backspace removes selection

keymap.set('v','<Up>', 'k', {noremap=true})
keymap.set('v', 'k', 'ge', { noremap = true })
keymap.set('v', 'l', '<C-S-Right>', { noremap = true })

keymap.set("v", "x", '"+ygxi', { noremap = true }) -- Cut selection

keymap.set('i', '<C-e>', '<C-o>:', {noremap=true}) -- Makes it easier to get to commands

keymap.set({'n','v'}, 'e', '$', {noremap=true}) -- Go to end of line

keymap.set({'n','v'}, 'b', '0', {noremap=true}) -- Go to beginning of line

keymap.set("i", "<Esc>", "<Esc>l", {noremap=true})

keymap.set("n", "o", "<Cmd>Telescope buffers<CR>", {noremap=true})

keymap.set("n","<Esc>", function()
if vim.fn.getreg("/") ~= "" then
  vim.cmd([[let @/ = ""]])
  return ""
else
  return "<Esc>"
end
end, {expr=true, noremap=true}) -- Clear search pattern if there is any

-- LaTex related commands
-----------------------------------
keymap.set("i", "<Tab>", function()
	if vim.bo.filetype == 'tex' then
		return [[\tab]]
	else
		return "<Tab>"
	end
end, {expr=true, noremap=true})

keymap.set("i", "<Enter>", function()
	if vim.bo.filetype == 'tex' then
		return [[

\n
]]
	else
		return "<Enter>"
	end
end, {expr=true, noremap=true})

keymap.set("n", "r", function()
	if vim.bo.filetype == 'tex' then
		return ":!pdflatex -synctex=1 --recorder -interaction=nonstopmode ".. vim.fn.expand("%:p")
	else
		return "r"
	end
end, {expr=true, noremap=true})
-----------------------------------------
