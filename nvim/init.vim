" |-- init.vim for Neovim --|

" TODO: Browse the past to discover the future
"       https://github.com/cbzehner/dotfiles/blob/b74e54c/nvim/init.vim
"       https://github.com/jordwalke/VimBox


" |-- Plugged --|
call plug#begin('~/.config/nvim/plugged')

Plug 'w0rp/ale'            " Asynchronous Lint Engine
Plug 'ervandew/supertab'
Plug 'mhinz/vim-signify'   " Show version control info in vim-gutter

 " Language Server Protocol support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"Plug 'roxma/nvim-completion-manager'  " Autocompletion framework
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'} " Javascript Autocompletion
Plug 'roxma/ncm-flow' " Javascript Flow Autocompletion
Plug 'calebeby/ncm-css' " CSS Autocompletion


Plug 'christoomey/vim-tmux-navigator' " Seamlessly navigate between vim and tmux splits
Plug 'pbrisbin/vim-mkdir' " Create non-existent directories when saving

" Navigation
Plug 'scrooloose/nerdtree' " <Ctrl-n>
Plug 'ctrlpvim/ctrlp.vim'  " <Ctrl-P>
Plug 'jremmen/vim-ripgrep' " Use ripgrep in Vim with :Rg

" Layout
Plug 'vim-airline/vim-airline'
Plug 'godlygeek/tabular' " Align text for better whitespace art

" Language Specific
Plug 'rust-lang/rust.vim', { 'for': [ 'rust' ] }
Plug 'racer-rust/vim-racer', { 'for': [ 'rust' ] }
Plug 'parsonsmatt/intero-neovim', { 'for': [ 'haskell', 'cabal' ] }
Plug 'neovimhaskell/haskell-vim', { 'for': [ 'haskell', 'cabal' ] }
Plug 'alx741/vim-hindent', { 'for': [ 'haskell', 'cabal' ] }
Plug 'hhvm/vim-hack', { 'for': [ 'php' ] }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
" Plug 'ngmy/vim-rubocop', { 'for': [ 'ruby' ] }
call plug#end()

" Now Perform The Installation Check:
"==============================
let everythingInstalled = !len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
if everythingInstalled || 2==confirm("Download and Install Plugins (Restart Afterwards To Take Effect)?", "&Yes\n&No", 1)
  " Place all the rest of your `~/.vimrc` config HERE!
else
  autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | echomsg "Restart Vim Now!" | let xx=confirm("Restart For Plugins to Take Effect.")
    \| endif
endif


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

if !&scrolloff
  set scrolloff=5       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

set hlsearch            " Highlight search results.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set incsearch           " Incremental search.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Ignore the following files globally inside Vim
" Credit: https://elliotekj.com/2016/11/22/setup-ctrlp-to-use-ripgrep-in-vim/
set wildignore+=*/.git/*,*/tmp/*,*.swp

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Imagine how much time and strain this binding will save you over the next thirty years of vim usage.
" nnoremap ; :
nnoremap ;; ;

" Sort imports for JS/CSS
" nnoremap <silent> <leader>i vip:'<, '>sort /.\{-}\(require\\|from\)/ i<CR>

" Search and Replace
" nmap <Leader>s :%s//g<Left><Left>

" Run tests on the current file 
augroup testCurrentFile
  au!
  au FileType php           nnoremap <C-t> :w !t %<CR>
  au FileType javascript    nnoremap <C-t> :w !jest %<CR>
  au FileType rust          nnoremap <C-t> :w !cargo test<CR>
  au FileType haskell       nnoremap <C-t> :w !stack test<CR>
augroup END

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>n :call NumberToggle()<cr>

nnoremap Q @q   " Use Q to execute default register.

" Make the dot command work as expected in visual mode (via
" https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04)
vnoremap . :norm.<CR>

" Allows you to visually select a section and then hit @ to run a macro on all lines
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


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

" Highlight characters which exceed 100 columns in length
match ErrorMsg '\%>100v.\+'

" Highlight current cursor column
:hi CursorColumn cterm=NONE ctermbg=237 ctermfg=white
:set cursorcolumn
:hi CursorLine cterm=NONE ctermbg=237 ctermfg=white
:nnoremap <Leader>c :set cursorline!<CR>

map <C-n> :NERDTreeToggle<CR>
"map <C-P> :CtrlP<CR>


" |-- Plugin Specific --|

" ----- autozimu/LanguageClient-neovim ----- 
" a basic set up for LanguageClient-Neovim
" << LSP >> {{{
let g:LanguageClient_autoStart = 1
nnoremap <leader>lcs :LanguageClientStart<CR>

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'go': ['go-langserver'] }

noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>
" }}}

" ----- ctrlpvim/ctrlp.vim -----
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp' " Cache results
if executable('rg') " Use rg instead of vim built-in.
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif

" From https://blog.jez.io/haskell-development-with-neovim
" ----- neovimhaskell/haskell-vim -----

" Align 'then' two spaces after 'if'
let g:haskell_indent_if = 3
" Indent 'where' block two spaces under previous body
let g:haskell_indent_before_where = 2
" Allow a second case indent style (see haskell-vim README)
let g:haskell_indent_case_alternative = 1
" Only next under 'let' if there's an equals sign
let g:haskell_indent_let_no_in = 0

" ----- hindent & stylish-haskell -----

" Indenting on save is too aggressive for me
let g:hindent_on_save = 1

" Helper function, called below with mappings
function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

" Key bindings
augroup haskellStylish
  au!
  " Just hindent
  au FileType haskell nnoremap <leader>hi :Hindent<CR>
  " Just stylish-haskell
  au FileType haskell nnoremap <leader>hs :call HaskellFormat('stylish')<CR>
  " First hindent, then stylish-haskell
  au FileType haskell nnoremap <leader>hf :call HaskellFormat('both')<CR>
augroup END

" ----- rust-lang/rust.vim -----
let g:rustfmt_autosave = 1

" ----- w0rp/ale -----

" Get stack support for 'stack-ghc-mod'
let g:ale_fixers = {
\   'haskell': [
\     'hlint'
\   ],
\   'javascript': [
\     'eslint'
\   ]
\}

" ----- mhinz/vim-signify -----

" Only enable for Git and Mercurial
let g:signify_vcs_list = [ 'git', 'hg' ]

" ----- parsonsmatt/intero-neovim -----

" Prefer starting Intero manually (faster startup times)
let g:intero_start_immediately = 0
" Use ALE (works even when not using Intero)
let g:intero_use_neomake = 0

augroup interoMaps
  au!

  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  au FileType haskell map <leader>t <Plug>InteroGenericType
  au FileType haskell map <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>
  au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

" ---- christoomey/vim-tmux-navigator ----
" https://robots.thoughtbot.com/seamlessly-navigate-vim-and-tmux-splits
" See ~/.tmux.conf
