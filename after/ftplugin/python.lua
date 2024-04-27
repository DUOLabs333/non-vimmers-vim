local HOME=os.getenv("HOME")
vim.lsp.start({
  name = 'Python-jedi',
  cmd = {HOME .. "/.local/bin/jedi-language-server"},
  root_dir=HOME
})

