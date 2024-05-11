vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

lvim.leader = "space"
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  timeout = 1000,
}
lvim.format_on_save = true
lvim.colorscheme = "mellow"

lvim.keys.normal_mode["ff"] = ":Telescope find_files<cr>"
lvim.keys.normal_mode["fg"] = ":Telescope live_grep<cr>"
lvim.keys.normal_mode["fh"] = ":Telescope help_tags<cr>"
lvim.keys.normal_mode["fm"] = ":Telescope gitmoji<CR>"
lvim.keys.normal_mode["<A-n>"] = ":Neogit<cr>"
lvim.keys.normal_mode["fs"] = ":vsplit<cr>"
lvim.keys.normal_mode["ft"] = ":vert terminal<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-n>"] = ":NvimTreeToggle<cr>"
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<leader><Tab>p"] = ":BufferLinePick<cr>"
lvim.keys.normal_mode["<leader>p"] = ":BufferLineTogglePin<cr>"
for i = 1, 9 do
  lvim.keys.normal_mode[string.format("<Leader><Tab>%d", i)] = string.format(":BufferLineGoToBuffer %d<CR>", i)
end

lvim.keys.normal_mode["<S-e>"] = ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>"
lvim.keys.normal_mode["fb"] = ":Telescope file_browser path=%:p:h<cr>"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.auto_install = true
