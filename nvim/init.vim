call plug#begin('~/.config/nvim/plugged')

" General
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'

" Pretty
"   Vim Airline
Plug 'vim-airline/vim-airline'

" Utilities
"   Autoformatter for a variety of languages
Plug 'Chiel92/vim-autoformat'
"   Vim CmdLine
Plug 'jalvesaq/vimcmdline'
"   Pandoc / Markdown
Plug 'vim-pandoc/vim-pandoc', { 'for': [ 'pandoc', 'markdown' ] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'markdown' ] }

" Language Specific
"   Elm
Plug 'lambdatoast/elm.vim', { 'for': [ 'elm' ] }
"   Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': [ 'haskell', 'cabal' ] }
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'mpickering/hlint-refactor-vim', {'for': 'haskell'}
"     Required for ghcmod-vim
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
"   Lisp
Plug 'vim-scripts/paredit.vim', { 'for': [ 'scheme', 'lisp', 'commonlisp' ] }
"   Hack/HHVM
Plug 'hhvm/vim-hack', { 'for': [ 'php' ] }
"   Javascript
Plug 'flowtype/vim-flow', { 'for': [ 'javascript' ] }
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

"set termguicolors      " Enable True Color (https://gist.github.com/XVilka/8346728)
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
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

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

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


" |--- Mappings ---|
let mapleader = ","
imap jk <Esc>

" Remap the window commands to <Leader><key> combination
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" Toggle paste mode
":nnoremap <Leader>p :set paste!<CR>

" Highlight characters which exceed 80 columns in length
match ErrorMsg '\%>80v.\+'

" Highlight current cursor column
:hi CursorColumn cterm=NONE ctermbg=237 ctermfg=white
:set cursorcolumn
:hi CursorLine cterm=NONE ctermbg=237 ctermfg=white
:nnoremap <Leader>c :set cursorline!<CR>

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


" |--- Plugins ---|
" Neomake
" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

" Disable inherited syntastic
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": [] }

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

" Use Deoplete
let g:deoplete#enable_at_startup = 1

" Vim CmdLine
let cmdline_vsplit = 1        " Split the window vertically
let cmdline_esc_term = 1      " Remap <Esc> to :stopinsert in Neovim terminal
let cmdline_in_buffer = 0     " Start the interpreter in a Neovim buffer
let cmdline_term_height = 15  " Initial height of interpreter window or pane
let cmdline_term_width = 80   " Initial width of interpreter window or pane
let cmdline_tmp_dir = '/tmp'  " Temporary directory to save files
let cmdline_outhl = 1         " Syntax highlight the output

" html5 syntax
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" javascript
let g:jsx_ext_required = 0

" flow
let g:flow#autoclose = 1
let g:flow#enable = 0

" go to definition
noremap gd :<C-U>call <SID>go_to_definition()<CR>
function! s:go_to_definition()
  if &filetype =~ 'javascript'
    FlowJumpToDef
  elseif &filetype =~ 'php'
    HackGotoDef
  else
    normal! gd
  endif
endfunction

" get type info
noremap K :<C-U>call <SID>get_help()<CR>
function! s:get_help()
  if &filetype =~ 'javascript'
    FlowType
  elseif &filetype =~ 'php'
    HackType
  else
    normal! K
  endif
endfunction

" merge conflict motion, borrowed from tpope/vim-unimpaired
noremap [n :<C-U>call <SID>next_conflict(1)<CR>
noremap ]n :<C-U>call <SID>next_conflict(0)<CR>
function! s:next_conflict(reverse)
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction


" |--- Language Specific ---|
" Vala
"   Set detection of Vala files (https://wiki.gnome.org/Projects/Vala/Vim)
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead,BufNewFile *.vala,*.vapi setfiletype vala
"   Set vala files to default to 4 spaces
autocmd FileType vala setlocal shiftwidth=2 softtabstop=4

" Haskell
"   Hook into ghc-mod's code competion capabilities
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
"   Use neco-ghc for completion
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc


" |--- Misc. ---|
" fb specifics
let g:hack#enable = 0
let g:fb_default_opts = 0
try
  source $ADMIN_SCRIPTS/master.vimrc
  source /home/engshare/admin/scripts/vim/biggrep.vim
catch
endtry

"   Specify syntax highlighting colors
if &t_Co == 256
  let cmdline_color_input = 247
  let cmdline_color_normal = 39
  let cmdline_color_number = 51
  let cmdline_color_integer = 51
  let cmdline_color_float = 51
  let cmdline_color_complex = 51
  let cmdline_color_negnum = 183
  let cmdline_color_negfloat = 183
  let cmdline_color_date = 43
  let cmdline_color_true = 78
  let cmdline_color_false = 203
  let cmdline_color_inf = 39
  let cmdline_color_constant = 75
  let cmdline_color_string = 79
  let cmdline_color_stderr = 33
  let cmdline_color_error = 15
  let cmdline_color_warn = 1
  let cmdline_color_index = 186
endif
