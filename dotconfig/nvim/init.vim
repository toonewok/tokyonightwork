set clipboard+=unnamedplus
set laststatus=2
set number
set noswapfile
set termguicolors
syntax enable
call plug#begin()

" List your plugins here
" Using Vim-Plug:
" Plug 'ellisonleao/gruvbox.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'elkowar/yuck.vim'
call plug#end()
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
lua require'colorizer'.setup()
" set background=none
"silent! colorscheme gruvbox
