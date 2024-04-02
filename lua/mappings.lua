local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

keymap.set("v", "<C-c>", '"+y', { noremap = true }) -- Copy to clipboard
-- keymap.set("v", "v", '"+p', { noremap = true }) -- Paste from clipboard


keymap.set('i', '<C-z>', '<Cmd>u<CR>', { noremap = true }) --Undo
keymap.set('i', '<C-y>', '<C-o><C-r>', { noremap = true }) -- Redo (Could replace with <C-o><C-r>)

keymap.set("i", "<C-.>", "<C-o>", {noremap=true}) -- Since <C-o> is being used already, I can't use it for recursive maps

--keymap.set('n', 'c', 'Zl',{remap=true}) -- Activate spellcheck corrections

api.nvim_create_user_command("Spell", "call spelunker#correct_from_list()",{})
api.nvim_create_user_command("Errors", "Trouble",{})

keymap.set('i', '<C-Left>', '<Esc>bi', { noremap = true }) -- Goes to beginning of previous word
keymap.set('i', '<C-Right>', '<Esc>ea', { noremap = true }) -- Goes to end of next word


keymap.set("v", "<C-Left>", "b", {noremap=true})
keymap.set("v", "<C-Right>", "e", {noremap=true})

keymap.set('i', '<C-S-Right>', '<C-.>v<C-Right>', {remap=true})
keymap.set('i', '<C-S-Left>', '<Left><C-.>v<C-Left>', {remap=true}) -- Have to move cursor back one character before continuing as <C-o>/<C-.> moves the cursor one character to the right 

keymap.set('v', '<C-S-Left>', '<C-Left>', { remap = true })
keymap.set('v', '<C-S-Right>', '<C-Right>', { remap = true })

--keymap.set('n', 'i', 'a', {noremap=true})


keymap.set('i', '<C-d>', '<Esc><Cmd>t.<CR>ka', {noremap=true}) -- Duplicate line without moving cursor

keymap.set('i', '<C-q>', '<Cmd>qa<CR>', {noremap=true}) -- Quit without saving

keymap.set('i', '<C-w>', '<Cmd>:bd<CR>', {noremap=true}) -- Close window

keymap.set('i', '<C-s>', '<Cmd>w<CR>', {noremap=true}) -- Save

keymap.set('v', '<BS>', '"_di', { noremap = true }) -- Backspace removes selection

keymap.set('v','<Up>', 'gk', {noremap=true}) -- Respect wrapped lines
keymap.set('v','<Down>', 'gj', {noremap=true})

keymap.set('v','<C-S-Up>', '<Up>', {remap=true}) -- Respect wrapped lines
keymap.set('v','<C-S-Down>', '<Down>', {remap=true})

keymap.set("i", "<Space>", "<Space><C-g>u", {noremap=true}) -- Set undo per word

cmp=require("cmp")
keymap.set('i','<Up>', function()
	if cmp.visible() then
		cmp.select_prev_item({ behavior = cmp.SelectBehavior})
		return ""
	else
		return "<C-o>gk"
	end
end, {expr=true, noremap=true})

keymap.set('i','<Down>', function()
	if cmp.visible() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior})
		return ""
	else
		return "<C-o>gj"
	end
end, {expr=true, noremap=true})

keymap.set("i", "<C-n>", "<C-o>n", {noremap=true}) -- Going forwards in a search
keymap.set("i", "<C-p>", "<C-o>N", {noremap=true}) -- Going backwards in a search


keymap.set("v", "<C-x>", '"+d', { noremap = true }) -- Cut selection

keymap.set('i', '<C-e>', '<C-o>:', {noremap=true}) -- Makes it easier to get to commands

keymap.set("i", "<C-'>", '<Esc>g$a', {noremap=true}) -- Go to end of line

keymap.set("i", '<C-;>', '<Esc>g0i', {noremap=true}) -- Go to beginning of line

keymap.set("v", "'", 'g$', {noremap=true}) -- Go to end of line

keymap.set("v", ';', 'g0', {noremap=true}) -- Go to beginning of line

keymap.set("i","<C-S-'>","<C-.>v'<Left>",{remap=true})
keymap.set("i","<C-S-;>","<C-.>v;",{remap=true})
keymap.set("v","<C-S-'>","'<Left>",{remap=true})
keymap.set("v","<C-S-;>",";",{remap=true})
--keymap.set("i", "<Esc>", "<Esc>`^", {noremap=true})

keymap.set("i", "<C-o>", "<Cmd>Telescope buffers<CR>", {noremap=true})

-- keymap.set("v", "i", "a", {remap=true})

keymap.set("i","<Esc>", function()
	vim.cmd("TroubleClose")
	if cmp.visible() then
	cmp.abort()
	return ""
end

if vim.fn.getreg("/") ~= "" then
  vim.cmd([[let @/ = ""]])
  return ""
else
  return "<Esc>"
end
end, {expr=true, noremap=true}) -- Clear search pattern if there is any

keymap.set("i", "<C-f>", function()
return "<C-o>/"
end, {expr=true, noremap=true})

keymap.set("v","<C-S-]>", ">gv", {noremap=true}) -- Indent
keymap.set("v","<C-S-[>", "<gv", {noremap=true}) -- Deindent

--keymap.set("n", ";", ":", {noremap=true})



------------------LaTex related commands-----------------------------------
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

keymap.set("i", "<C-r>", function()
	if vim.bo.filetype == 'tex' then
		return "<Cmd>!pdflatex -synctex=1 --recorder -interaction=nonstopmode ".. vim.fn.shellescape(vim.fn.expand("%:p"),1).."<CR>"
	else
		return "r"
	end
end, {expr=true, noremap=true})
-----------------------------------------
