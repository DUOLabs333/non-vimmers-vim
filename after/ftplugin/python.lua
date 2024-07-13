local HOME=os.getenv("HOME")
vim.lsp.start({
  name = 'Python-jedi',
  cmd = {"jedi-language-server"},
  root_dir=HOME
})

