"""""""""""""""""""""""""""""""""""""""""""""""" PLUGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" auto-install Plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" init plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug '~/.plugs-cache/fzf/'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }             " need node.js and npm
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/neosnippet.vim'
Plug 'mhartington/oceanic-next'
Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
" Plug 'plasticboy/vim-markdown'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""" MAPPINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" disable arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"" insert empty line with no insert mode (vsc)
noremap <leader>o o<Esc>
noremap <leader>O O<Esc>

"" insert empty line and go back (vsc)
noremap <leader><leader>o o<Esc>k
noremap <leader><leader>O O<Esc>j

"" insert empty lines beneath and above and i-mode (vsc)
noremap <leader><leader>go O<Esc>jo<Esc>ki

"" esc remap (vsc)
" imap jk <Esc>
imap <leader>j <Esc>

"" search and center screen (vsc)
noremap <leader>n nzz
noremap <leader>N Nzz

"" move 5 up/down (vsc)
" noremap <leader>k 10k
" noremap <leader>j 10j

"" replace word/WORD (vsc)
noremap S ciw<C-r>0<Esc>
noremap gS ciW<C-r>0<Esc>

"" save / save&close / quit without save (vsc)
noremap <leader>f :w<CR>
imap <leader>f <Esc>:w<CR>
noremap <leader>z :x<CR>
noremap <leader>q :q!<CR>
" noremap nm :w<CR>
" imap nm <Esc>:w<CR>
" noremap ZZ :x<CR>
" noremap ZQ :q!<CR>

"" paste at the end of line (vsc)
noremap <leader><leader>p A<space><Esc>p
"" paste with space at the begining
noremap <leader>p a<space><Esc>p

"" paste beneath paragraph (vsc) - use gP / P
" noremap <leader><leader>p }p

"" delete action without register (vsc)
noremap <leader>d "_d

"" fzf - find file
nnoremap <C-p> :FZF<CR>
"" dont use :Files it changes cwd

nnoremap <C-A-p> :History<CR>
" nnoremap <C-A-l> :Locate

"" fzf - find all files (hidden too)
command! -bang -nargs=? FilesAll
  \ call fzf#run(fzf#wrap('all-files-in-cwd', {'source': 'find . -type f'}), <bang>0)

" [CTags] Command to generate tags file
" Use: :Tags - generate file when no present
let g:fzf_tags_command = 'ctags -R --exclude=.git .'

"" fzf - extra key bindings
function! s:copy_results(lines)
  let joined_lines = join(a:lines, "\n")
  if len(a:lines) > 1
    let joined_lines .= "\n"
  endif
  let @+ = joined_lines
endfunction

let g:fzf_action = {
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-x': 'split',
  \ 'ctrl-y': function('s:copy_results'),
  \ }

"" fzf - qnb integration
command! -bang -nargs=? Qnb
  \ call fzf#run(fzf#wrap('qnb-files', {'source': 'ag --follow --ignore .git -g ""', 'dir': '/mnt/g/qnb/'}), <bang>0)

nnoremap gq :Qnb<CR>

"" fzf - tiljs integration
command! -bang -nargs=? Tiljs
  \ call fzf#run(fzf#wrap('qnb-files', {'source': 'ag --follow --ignore .git -g ""', 'dir': '/mnt/h/dev/tiljs/'}), <bang>0)

nnoremap gt :Tiljs<CR>

"" fzf - dev
command! -bang -nargs=? AgDev
  \ call fzf#run(fzf#wrap('ag-dev', {'source': 'ag --follow --ignore .git -g ""', 'dir': '/mnt/h/dev/'}), <bang>0)

nnoremap <leader>dev :AgDev<CR>

"" qnb commands
command! Qgs :!qnb git status
command! Qgc :!qnb git commit
command! -nargs=1 Qc :!qnb create new-note dump <q-args>
command! -nargs=* Qa :!qnb add new-topic dump <q-args>

"" edit/reload vimrc
nmap <leader>rce :e ~/.vimrc<CR>
nmap <leader>rcr :so ~/.vimrc<CR><Space>

" buffer navigation
nnoremap <leader>bd :bd<CR>
" delete all buffers
nnoremap <leader><leader>bd :bufdo :bd<CR>
" nnoremap <leader>b :buffer *
nnoremap ,, :Buffers<CR>
" too long, so changed it
" nnoremap <leader>b :Buffers<CR>
nnoremap <S-tab> :b#<CR>
" nnoremap gp :bp<CR>
" nnoremap gn :bn<CR>
" to way out coz gn is used to search
nnoremap gl :ls<CR> :ls<CR>:b<Space>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"" remove all buffers but current one
command! BufDoDelAll silent! execute "%bd|e#"
" command! BufOnly silent! execute "%bd|e#|bd#"
"" [Vim: Close All Buffers But This One - Stack " Overflow](https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one)
nnoremap <leader>bda :BufDoDelAll<CR>

" comments
nmap <C-_> gcc
  "" as ctrl-/

" closing brackets
inoremap " ""<left>
inoremap ` ``<left>
" inoremap ' ''<left>  " not often used
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <leader>( ()
inoremap <leader>[ []
inoremap <leader>< <><left>
  " use <C-v> in insert mode to escape it and use single char

" paths
" in insert - parent dir
inoremap <leader>pd <C-R>=expand("%:p:h")<CR>
" in insert - current file
inoremap <leader>pf <C-R>=expand("%:p")<CR>
" in insert - only filename without extension
inoremap <leader>pff <C-R>=expand("%:t:r")<CR>
" in insert - only filename
inoremap <leader>pfff <C-R>=expand("%:t")<CR>
" in normal - copy file path (full) to the clipboard
nnoremap <leader>cf :let @* = expand("%:p")<CR>

"" prettier
"nmap <Leader>pr <Plug>(Prettier)
"workaround:
nmap <Leader>pr :w<CR>:PrettierCli --write <C-R>=expand("%:p")<CR><CR>:e!<CR>
  "" need node.js and prettier installed

"" gitgutter
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

"" spellcheck
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>
nnoremap <F6> :setlocal spell! spelllang=pl<CR>

"" relatvie line numbers toggle
noremap <F3> :set invrelativenumber<CR>
inoremap <F3> <C-O>:set invrelativenumber<CR>

"" syntax highlighting refresh
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

"" for variable change (like global replace)
"" replace a word
nnoremap gr *:%s///g<left><left>
"" replace a WORD
nnoremap gR :%s/<c-r><c-a>//g<left><left>
"" fast replace
nnoremap <leader>gr *Ncgn
"" visual selection to search
vnoremap // y/<C-R>"<CR>

"" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <leader><Space> :nohlsearch<Bar>:echo<CR>

"" neosnippet key-mappings
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

nnoremap <C-A-k> :NeoSnippetEdit<CR>

"" save file in cwd
nnoremap <leader>e :e <C-R>=expand("%:p:h")<CR>/

"" unfold
nnoremap <Space> za

"" * behavior in visual mode
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

"" Bash C-a and C-e in the insert mode
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I

inoremap <leader>l <Esc>la
  "" ?? book ?

"" golang setups
autocmd FileType go nmap ,gr <Plug>(go-run)
autocmd FileType go nmap ,gb <Plug>(go-build)
autocmd FileType go nmap ,gt <Plug>(go-test)
autocmd FileType go nmap ,gc <Plug>(go-coverage)
autocmd FileType go nmap ,gi :GoImport<Space>
autocmd FileType go nmap ,gd :GoDrop<Space>
autocmd FileType go nmap ,gt :GoDeclsDir<CR>
autocmd FileType go nmap ,ga :GoAlternate<CR>

let g:go_auto_type_info = 1
  "" vim-go - show type signature in command line

let g:go_fmt_command = "goimports"
  "" when its on no need :GoImport and :GoDrop?

"" extra colors for vim-go syntax
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_auto_sameids = 1
  "" highlight variables (vim-go)

let g:go_loaded_gosnippets = 1
    "" disable vim-go snippets

"" quickfix window
noremap ]c :cnext<CR>
noremap [c :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

"" yank line but withoun new line
nnoremap <leader>y ^y$

"" Write Mode - goyo
function! WriteMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  "" gruvbox
  let g:gruvbox_contrast_dark = 'soft'
  colorscheme gruvbox
endfunction
""TODO: add reverse function!

command! WriteMode call WriteMode()
nmap <leader>w :WriteMode<CR>

"" substitution pattern
noremap <leader>s :%s:::g<Left><Left><Left>
noremap <leader>sc :%s:::cg<Left><Left><Left><Left>

"" rename file
function! RenameFile()
    let oldName = expand('%')
    let newName = input('New file name: ', expand('%'), 'file')
    if newName != '' && newName != oldName
        exec ':saveas ' . newName
        " exec ':silent !rm ' . oldName
        exec ':bdelete' oldName
        "" not working properly !!!
        redraw!
    endif
endfunction
command! Mv call RenameFile()

"" fixing & command (PV - tip 93)
"" using this?
" nnoremap & :&&<CR>
" xnoremap & :&&<CR>

"" Ale configuration
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'

let b:ale_fixers = {'javascript': ['eslint']}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
nmap <F7> <Plug>(ale_fix)

"" Manual markdown folding def
function MarkdownLevel()
  let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
      return "="
    else
      return ">" . len(h)
    endif
endfunction
au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr

"" in normal mode add space before cursor
nnoremap <A--> i<space><esc><right>

"" erase line - not removing
nnoremap <leader>cc cc<Esc>

"" vim-emmet
" [Self Closing Tag Syntax and Quoteless attributes? · Issue #341 · mattn/emmet-vim](https://github.com/mattn/emmet-vim/issues/341)
inoremap <C-y>e <esc>:call emmet#expandAbbr(0,"")<cr>h:call emmet#splitJoinTag()<cr>wwi
nnoremap <C-y>e :call emmet#expandAbbr(0,"")<cr>h:call emmet#splitJoinTag()<cr>ww

"" Custom Read command (:r !)
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

""""""""""""""""""""""""""""""""""""""""""""""""  ABBREVIATIONS """""""""""""""""""""""""""""""""""""""""""""""""""""""""
:iab konw know
:iab cosnt const

"""""""""""""""""""""""""""""""""""""""""""""""" SETTINGS """""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" etc...
set timeout timeoutlen=1000                      " key combination timeout
set ff=unix
syntax on                                        " syntax highlights
set directory^=$HOME/.vim/temp//                 " swap files dir
set nrformats=                                   " number format for numbers like 007
set splitbelow splitright	                       " splits open at the bottom and right, which is non-retarded, unlike vim defaults.
autocmd BufWritePre * %s/\s\+$//e                " automatically deletes all trailing whitespace on save.
set encoding=utf-8
set wildmenu	                                   " nvim has it so only for vim compatibility
set wildmode=full
set updatetime=500	                             " smaler for git gutter plugin
set noswapfile                                   " test - no swap files
set wrap linebreak nolist                        " not working? why?

"" folds
set foldmethod=syntax                            " syntax highlighting items specify folds
let javaScript_fold=1                            " activate folding by JS syntax
set foldlevelstart=99                            " start file with all folds opened
set foldnestmax=2

"" tabs
"" default
filetype plugin indent on
set tabstop=2                                    " show existing tab with 2 spaces width
set shiftwidth=2                                 " when indenting with '>', use 2 spaces width
set expandtab                                    " on pressing tab, insert 2 spaces

if has("autocmd")
  " filetype on
  autocmd FileType sh setlocal tabstop=2 shiftwidth=2 expandtab
  " autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab
  " autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
endif

"" line numbers
set relativenumber
set number

"" cursor shape in different modes (only arch)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"" colors & themes
set bg=dark
set termguicolors     " enable true colors support

"" ayu
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" let ayucolor="light"  " for light version of theme
" colorscheme ayu

"" gruvbox
" colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'soft'

"" nord
colorscheme nord

"" oceanic
" let g:airline_theme='oceanicnext'
" colorscheme OceanicNext

"" save views and folds
"" simple one:
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent! loadview
""" more advanced version
let g:skipview_files = [
            \ '[EXAMPLE PLUGIN BUFFER]'
            \ ]
function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile'
        " Buffer is marked as not a file
        return 0
    endif
    if empty(glob(expand('%:p')))
        " File does not exist on disk
        return 0
    endif
    if len($TEMP) && expand('%:p:h') == $TEMP
        " We're in a temp dir
        return 0
    endif
    if len($TMP) && expand('%:p:h') == $TMP
        " Also in temp dir
        return 0
    endif
    if index(g:skipview_files, expand('%')) >= 0
        " File is in skip list
        return 0
    endif
    return 1
endfunction
augroup vimrcAutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePost,BufLeave,WinLeave *.* if MakeViewCheck() | mkview | endif
    autocmd BufWinEnter *.* if MakeViewCheck() | silent! loadview | endif
augroup end

"" simple sessions manage setup (no plugin)
if !isdirectory($HOME.'/.vim-sessions')
    silent call mkdir ($HOME.'/.vim-sessions', 'p')
endif

let g:sessions_dir = '~/.vim-sessions'

exec 'nnoremap ZS :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap ZR :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

autocmd VimLeave * mks! ~/.vim-sessions/shutdown-session.vim                " automatically save the current session whenever vim is closed

"" clipboard for wsl
set clipboard=unnamedplus

"" airline
" let g:airline_theme='base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"" fix proper rendering in tmux window
let g:airline#extensions#tmuxline#enabled = 0

"" automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

"" prettier
let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

"" neosinppet
" which disables all runtime snippets
let g:neosnippet#disable_runtime_snippets = { '_' : 1, }

let g:neosnippet#snippets_directory='~/.snippets'

"" gf configuration
"" open file under cursor
:set suffixesadd+=.md
:set path+=/mnt/g/qnb

"" cd util
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>ccd :pwd<CR>

"" Markdown
"" polyglot instead?
" let g:vim_markdown_folding_disabled = 0
" " let g:vim_markdown_override_foldtext = 0
" let g:vim_markdown_fenced_languages = ['bash=sh', 'javascript=js', 'go', 'html']
" let g:vim_markdown_new_list_item_indent = 0
" let g:vim_markdown_auto_insert_bullets = 0
" let g:vim_markdown_new_list_item_indent = 0

"" Links
let g:netrw_browsex_viewer="cmd.exe /C start"
  "" for WSL

"" Cursor
if !empty($ConEmuBuild)
    " let &t_SI = "\<Esc>[6 q"
    " let &t_SR = "\<Esc>[4 q"
    " let &t_EI = "\<Esc>[2 q"
    " let &t_SI.="\e[5 q"
    " let &t_SR.="\e[4 q"
    " let &t_EI.="\e[1 q"
endif

"" Activation of matchit that extends for html tags when using *
runtime macros/matchit.vim

"" Turn of Hot Module Reload (HMR) so file watchers like parcel can detect
"" changes in the watched files
"" https://stackoverflow.com/questions/55434553/parcel-watch-only-detects-first-file-change
set backupcopy=yes

set pastetoggle=<leader>x
