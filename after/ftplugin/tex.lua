local HOME=os.getenv("HOME")
vim.lsp.start({
  name = 'TexLab',
  cmd = {HOME .. "/.local/bin/texlab"},
  root_dir=HOME
})

