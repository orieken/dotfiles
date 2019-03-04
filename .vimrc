compiler ruby

set hlsearch
set number
set showmatch
set incsearch
set background=dark
set noshowmode
set hidden
set backspace=indent,eol,start
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set ruler
set wrap
set dir=/tmp//
set scrolloff=5
set autowrite
set nobackup
set nowritebackup
set noswapfile
set showcmd " display incomplete commands
set history=20
set wildmenu " visual autocomplete for command menu

set foldenable
set foldmethod=manual
set foldlevelstart=20

set ignorecase
set smartcase

set lazyredraw " redraw only when we need to.

if has('nvim')
  " live %s preview
  set inccommand=split
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

let path = expand('<sfile>:p:h')

" Exception not caught: ALE conflicts with Syntastic. Uninstall it, or disable this warning with `let g:ale_emit_conflict_warnings = 0` in your vimrc file, *before* plugins are loaded.
" let g:ale_emit_conflict_warnings = 0
if filereadable(expand(path . '/.vimrc.bundles'))
  exec 'source' . expand(path . '/.vimrc.bundles')
endif
if filereadable(expand(path . '/.vimrc.cucumber-js'))
  exec 'source' . expand(path . '/.vimrc.cucumber-js')
endif
filetype indent plugin on

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'

let html_use_css=1
let html_number_lines=0
let html_no_pre=1

" let g:no_html_toolbar = 'yes'
let NERDTreeShowHidden=1

" autocmd FileType ruby runtime ruby_mappings.vim
imap <C-L> <SPACE>=><SPACE>
map <silent> <LocalLeader>cj :!clj %<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>bd :bufdo :bd<CR>
map <silent> <LocalLeader>cc :TComment<CR>
map <silent> <LocalLeader>uc :TComment<CR>
nnoremap <silent> <LocalLeader><CR> :tabe<CR>
nnoremap <silent> <LocalLeader>[ :tabp<CR>
nnoremap <silent> <LocalLeader>] :tabn<CR>
nnoremap <silent> <LocalLeader><Space> :noh<CR>
nnoremap <silent> <LocalLeader>ws :%s/\s\+$//<CR>:let @/=''<CR><C-o>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap <F1> <ESC>
" move vertically by visual line
nnoremap j gj
nnoremap k gk

let test#javascript#jasmine#executable = 'npm test'
let test#javascript#jasmine#file_pattern = '\v^spec/.*spec(\.js)?\.(ts|js|jsx|coffee)$'

map <silent> <LocalLeader>ff :Files<CR>
map <silent> <LocalLeader>fg :GFiles<CR>
map <silent> <LocalLeader>fG :GFiles?<CR>
map <silent> <LocalLeader>fb :Buffers<CR>
map <silent> <LocalLeader>fc :Commits<CR>ap <silent> <LocalLeader>ff :CtrlP<CR>

if executable('tmux')
  let test#strategy = "vimux"
endif

let g:syntastic_typescript_tsc_fname = ''
autocmd FileType typescript setl omnifunc=LanguageClient#complete
autocmd FileType typescript setl completefunc=LanguageClient#complete
" autocmd FileType typescript setlocal completeopt+=menu,preview
let g:syntastic_aggregate_errors = 1
set completeopt=longest,menuone,preview
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-j> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-k> pumvisible() ? '<C-p>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" inoremap <expr><C-j>   pumvisible() ? "\<lt>C-n>" : "\<lt>C-j>"
" inoremap <expr><C-k>   pumvisible() ? "\<lt>C-p>" : "\<lt>C-k>"
" imap <expr><ENTER>   pumvisible() ? "\<lt>C-y>" : "\<lt>Enter>"
" map <silent> <Leader><c-i> :TsuImport<CR>
map <silent> <Leader><C-q> :call LanguageClient_textDocument_codeAction()<CR>

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" vimux commands
map <Leader>vt :VimuxTogglePane<CR>
map <Leader>vz :VimuxZoomRunner<CR>

map <silent> <Leader>rb :wa<CR> :TestFile<CR>
map <silent> <Leader>rc :wa<CR> :TestSuite<CR>
map <silent> <Leader>rf :wa<CR> :TestNearest<CR>
map <silent> <Leader>rl :wa<CR> :TestLast<CR>

cnoremap <Tab> <C-L><C-D>
cnoreabbrev W w

if version >= 700
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
    autocmd FileType tex setlocal spell spelllang=en_us
endif

colorscheme atom-dark-256

" Highlight trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Set up highlight group & retain through colorscheme changes
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Highlight too-long lines
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%126v.*/
highlight LineLengthError ctermbg=black guibg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black

" Comment colors
highlight Comment ctermfg=DarkMagenta
highlight clear SignColumn
highlight SignifySignAdd    cterm=bold ctermfg=119
highlight SignifySignDelete cterm=bold ctermfg=167
highlight SignifySignChange cterm=bold ctermfg=227

set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

set undodir=~/.vim/undo
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" ctrlp settings
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_max_files = 0
let g:ctrlp_switch_buffer = 1
let g:ctrlp_max_height = 20
let g:ctrlp_clear_cache_on_exit = 0
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore vendor
                                                        \ --ignore node_modules
                                                        \ --ignore .git
                                                        \ -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"-----------
" Searching
"-----------
cnoreabbrev Ag Ack!

set hlsearch
highlight Search ctermbg=black ctermfg=lightgray
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
map <LocalLeader>ag :Ack! '<C-R><C-W>'<Paste><Enter>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

autocmd FocusLost * stopinsert
autocmd VimResized * :wincmd = " auto resize vim when the window is resized

function! ToggleRelativeNumber()
  if &relativenumber
    set relativenumber!
  else
    set relativenumber
  endif
endfunction
nnoremap <silent> <LocalLeader>rr :call ToggleRelativeNumber()<cr>


" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

autocmd BufNewFile,BufRead *.jenkins set syntax=groovy
autocmd BufNewFile,BufRead *.stages set syntax=groovy

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" LanguageClient
let g:LanguageClient_serverCommands = {
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'kotlin': ['~/Projects/KotlinLanguageServer/build/install/kotlin-language-server/bin/kotlin-language-server'],
      \ }
let g:LanguageClient_rootMarkers = {
    \ 'typescript': ['tsconfig.json'],
    \ }
let g:ale_completion_enabled = '1'

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

hi NonText ctermbg=none
hi Normal guibg=NONE ctermbg=NONE
