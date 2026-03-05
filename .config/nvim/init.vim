set autoindent              " indent a new line the same amount as the line just typed
set backspace=indent,eol,start
" set backupdir=~/.cache/vim " Directory to store backup files.
set cc=80                   " set an 80 column border for good coding style
set clipboard=unnamedplus   " using system clipboard
set cursorline              " highlight current cursorline
set expandtab               " converts tabs to white space
set hlsearch                " highlight search 
set ignorecase              " case insensitive 
set incsearch               " incremental search
set mouse=a                 " enable mouse click
set mouse=v                 " middle-click paste with 
set nocompatible            " disable compatibility to old-time vi
set nofoldenable            " default to unfolded
set nowrap                  " disable wrapping
" set noswapfile            " disable creating swap file
set number                  " add line numbers
set shiftwidth=2            " width for autoindents
set showmatch               " show matching 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
" set spell                 " enable spell check (may need to download language package)
set tabstop=2               " number of columns occupied by a tab 
set ttyfast                 " Speed up scrolling in Vim
set wildmode=longest,list   " get bash-like tab completions

filetype plugin indent on   " allow auto-indenting depending on file type
filetype plugin on
syntax on                   " syntax highlighting

set smartcase
set smartindent
set autoindent
set relativenumber

lua require('plugins')

"colorscheme sonokai
colorscheme habamax
" Let's get some pretty columns up in this bayatch
:let &colorcolumn="2," . join(range(4, 999, 2), ",")
set colorcolumn=72          " show a bar at chr 72

" Some color tweaks
highlight Cursor guifg=white guibg=gray
highlight iCursor guifg=white guibg=red
highlight MatchParen guifg=#ffffff guibg=#006644
highlight Visual gui=reverse guifg=#dddddd guibg=#000000
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10


augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

let g:tagbar_ctags_bin = 'uctags'

" NERDTree stuff
nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize=40


" Make twig files use html syntax coloring
autocmd! BufReadPost *.twig set syntax=html

" DAP shortcuts
nmap <Leader>dR :lua require("dap").run_to_cursor()
nmap <Leader>dE :lua require("dapui").eval(vim.fn.input "[Expression] > ")
nmap <Leader>dT :lua require("dap").toggle_breakpoint()
nmap <Leader>dC :lua require("dap").set_breakpoint(vim.fn.input "[Condition] > ")
nmap <Leader>dU :lua require("dapui").toggle()
nmap <Leader>db :lua require("dap").step_back()
nmap <Leader>dc :lua require("dap").continue()
nmap <Leader>dd :lua require("dap").disconnect()
nmap <Leader>de :lua require("dapui").eval()
nmap <Leader>dg :lua require("dap").session()
nmap <Leader>dh :lua require("dap.ui.widgets").hover()
nmap <Leader>dS :lua require("dap.ui.widgets").scopes()
nmap <Leader>di :lua require("dap").step_into()
nmap <Leader>do :lua require("dap").step_over()
nmap <Leader>dp :lua require("dap").pause.toggle()
nmap <Leader>dq :lua require("dap").close()
nmap <Leader>dr :lua require("dap").repl.toggle()
nmap <Leader>ds :lua require("dap").continue()
nmap <Leader>dt :lua require("dap").toggle_breakpoint()
nmap <Leader>dx :lua require("dap").terminate()
nmap <Leader>du :lua require("dap").step_out()

" Telescope shortcuts
nmap <Leader>t :Telescope
nmap <Leader>tb :Telescope buffers<CR>
nmap <Leader>tl :lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"

" Fugitive conflict resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" coc.nvim autocompletion key
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
