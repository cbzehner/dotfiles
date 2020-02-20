" |-- init.vim for Neovim --|

  " TODO: Browse the past to discover the future
  "       https://github.com/cbzehner/dotfiles/blob/b74e54c/nvim/init.vim
  "       https://github.com/jordwalke/VimBox


" |--- Vim-Plug  ---|
  call plug#begin('~/.local/share/nvim/plugged') " Suggested Neovim directory

  " Utils
  Plug 'christoomey/vim-tmux-navigator' " Seamlessly navigate between vim and tmux splits
  Plug 'pbrisbin/vim-mkdir'             " Create non-existent directories when saving
  Plug 'tpope/vim-fugitive'             " A Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-surround'             " All about \"surroundings\": parentheses, brackets, quotes, XML tags, and more.
  Plug 'editorconfig/editorconfig-vim'  " Add support for .editorconfig files


  " Navigation
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf using Vim-Plug
  Plug 'junegunn/fzf.vim' " Use fzf in Vim with :Files

  " Language Support
  "Plug 'pangloss/vim-javascript' " Javascript syntax highlighting and indentation
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " A completion framework and language server client
  Plug 'sheerun/vim-polyglot'                     " A collection of language packs for Vim.

  " Themes
  Plug 'nanotech/jellybeans.vim'    " Install Jellybeans colorscheme

  call plug#end()

" |--- Settings ---|
    set relativenumber      " Display relative line numbers
    set number              " Show line number of current line
    set mouse=c             " Turn off mouse support
    set showcmd             " Show (partial) command in status line.
    set showmatch           " Show matching brackets.
    set showmode            " Show current mode.
    set ruler               " Show the line and column numbers of the cursor.
    set number              " Show the line numbers on the left side.
    set formatoptions+=o    " Continue comment marker in new lines.
    set textwidth=0         " Hard-wrap long lines as you type them.
    set expandtab           " Insert spaces when TAB is pressed.
    set tabstop=2           " Render TABs using this many spaces.
    set shiftwidth=2        " Indentation amount for < and > commands.
    set autochdir           " Updates the working directory to the directory of the open file.
    set undofile            " Maintain undo history between sessions
    set undodir=~/.config/nvim/undodir
    set foldmethod=indent   " Lines with equal indent form a fold.

    "set termguicolors      " Enable True Color (https://gist.github.com/XVilka/8346728)
    colorscheme jellybeans  " Set colorscheme to Jellybeans
    set noerrorbells        " No beeps.
    set modeline            " Enable modeline.
    set linespace=0         " Set line-spacing to minimum.
    set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

  " Easier split navigation
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

  " More natural splits
    set splitbelow          " Horizontal split below current.
    set splitright          " Vertical split to right of current.

  " Relative numbering
    function! NumberToggle()
      if(&relativenumber == 1)
        set nonumber
        set norelativenumber
      else
        set number
        set relativenumber
      endif
    endfunc

" |--- Mappings ---|
  let mapleader = ","
  imap jk <Esc>

  " Remap the window commands to <Leader><key> combination
    map <leader>h :wincmd h<CR>
    map <leader>j :wincmd j<CR>
    map <leader>k :wincmd k<CR>
    map <leader>l :wincmd l<CR>

  " Toggle paste mode
    :nnoremap <Leader>p :set paste!<CR>

  " Use Q to execute default register.
    nnoremap Q @q   

  " Make the dot command work as expected in visual mode (via
  " https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
    vnoremap . :norm.<CR>

  " Toggle between normal and relative numbering.
    nnoremap <leader>n :call NumberToggle()<cr>

  " Highlight characters which exceed 100 columns in length
    match ErrorMsg '\%>80v.\+'
    match ErrorMsg '\%>120v.\+'

  " Highlight current cursor column
    :hi CursorColumn cterm=NONE ctermbg=237 ctermfg=white
    :set cursorcolumn
    :hi CursorLine cterm=NONE ctermbg=237 ctermfg=white
    :nnoremap <Leader>c :set cursorline!<CR>

" |--- Terminal ---|
  " Exit from terminal buffer (Neovim) more easily (remaps Esc key in terminal)
  tnoremap <C-[> <C-\><C-n>

  " Open terminal buffer (M stands for the Alt key)
  nnoremap <M-t> :te<CR>

  " Switch to terminal buffer automatically (when only one terminal is
  " open)
  nnoremap <M-0> :b term://<CR>

  " Move between windows exactly the same way as usual
  tnoremap <C-j><C-k> <C-\><C-N>
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

" |--- Plugins ---|
  " Fuzzy Finder
    " Support Ctrl-P for searching
    nnoremap <C-p> :Files<CR>
    nnoremap <Leader>b :Buffers<CR>
    nnoremap <Leader>h :History<CR>

  " Conquer of Completion (Coc)
    " Run Prettier
    command! -nargs=0 Prettier :CocCommand prettier.formatFile


" |--- Language Specific ---|
  " |--- Javascript ---|

  " vim-javascript
  " augroup javascript_folding " Enables code folding for javascript based on syntax.
      " au!
      " au FileType javascript setlocal foldmethod=syntax
  " augroup END
