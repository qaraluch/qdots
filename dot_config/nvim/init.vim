"
"  Qaraluch's
"  ___   __    _  ___   _______        __   __  ___   __   __
" |   | |  |  | ||   | |       |      |  | |  ||   | |  |_|  |
" |   | |   |_| ||   | |_     _|      |  |_|  ||   | |       |
" |   | |       ||   |   |   |        |       ||   | |       |
" |   | |  _    ||   |   |   |   ___  |       ||   | |       |
" |   | | | |   ||   |   |   |  |   |  |     | |   | | ||_|| |
" |___| |_|  |__||___|   |___|  |___|   |___|  |___| |_|   |_|
"                                                      05.2020
"
"        Neovim Configuration File (init.vim)
"        It is part of the repo: https://github.com/qaraluch/qdots/
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  PLUGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Plug - plugin manager installer
" auto-install Plug
" see: https://github.com/junegunn/vim-plug
if empty(glob('~/.cache/vim/autoload/plug.vim'))
  silent !curl -fLo ~/.cache/vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Init plugins
call plug#begin('~/.cache/vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     "TODO: change for system binary file
Plug 'junegunn/fzf.vim'                                 "https://github.com/junegunn/fzf.vim
Plug 'dyng/ctrlsf.vim'																	"https://github.com/dyng/ctrlsf.vim
Plug 'tpope/vim-commentary'                             "https://github.com/tpope/vim-commentary
Plug 'sheerun/vim-polyglot'				                      "https://github.com/sheerun/vim-polyglot
Plug 'dracula/vim', { 'as': 'dracula' }			            "https://github.com/dracula/vim
Plug 'tpope/vim-surround'																"https://github.com/tpope/vim-surround
Plug 'itchyny/lightline.vim'                            "https://github.com/itchyny/lightline.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}         "https://github.com/neoclide/coc.nvim
Plug 'airblade/vim-gitgutter'                           "https://github.com/airblade/vim-gitgutter
" Plug 'arcticicestudio/nord-vim' 			                  "https://github.com/arcticicestudio/nord-vim
" Plug 'mileszs/ack.vim'																  "https://github.com/mileszs/ack.vim
call plug#end()

"" Plug commands:
" :PlugInstall [name ...]   - Install plugins
" :PlugUpdate [name ...]    - Install or update plugins
" :PlugClean[!]	            - Remove unlisted plugins (bang version will clean without prompt)
" :PlugUpgrade	            - Upgrade vim-plug itself
" :PlugStatus	              - Check the status of plugins

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Leader key (\)
" No need for leader key!
" Disadvantage is that it is also used in insert mode,
" so it cause lag effect
" Use default one: \
" - for special, not common command
" Used mental leader key: <Space>
" - for common edit commands
" Used mental leader key: '
" - for buffer and window navigation
" change leader key example (for reference):
" let mapleader=","

"" Theme & colors
" enable true colors support
set termguicolors
set background=dark
" nord theme - https://github.com/arcticicestudio/nord-vim
" colorscheme nord
" sracula theme - https://github.com/dracula/vim
colorscheme dracula

" lightline colorscheme
" https://github.com/itchyny/lightline.vim/blob/master/autoload/lightline/colorscheme/powerline.vim
" modified version of following colorscheme
      " \ 'colorscheme': 'powerline',
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ ['gray9', 'gray5', 'bold'], ['mediumcyan', 'gray3'] ]
let s:p.normal.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray2'] ]
let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray8', 'gray2'] ]
let s:p.inactive.left = s:p.inactive.right[1:]
let s:p.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:p.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['white', 'gray4'] ]
let s:p.visual.left = [ ['darkred', 'brightorange', 'bold'], ['white', 'gray4'] ]
let s:p.normal.middle = [ [ 'gray7', 'gray2' ] ]
let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right
let s:p.tabline.left = [ [ 'gray6', 'gray3' ] ]
let s:p.tabline.tabsel = [ [ 'darkestblue', 'mediumcyan' ] ]
let s:p.tabline.middle = [ [ 'gray6', 'gray3' ] ]
let s:p.tabline.right = [ [ 'gray5', 'gray3' ] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]
let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#fill(s:p)
" get rid of: -- INSERT --; mode information is displayed in the statusline"
set noshowmode
let g:lightline = {
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ }

"" General Settings
set encoding=utf-8
" file format
set ff=unix
set autoindent
set smartindent
set nowrap
set noswapfile
" better search
" tip: the search /the\c is always case insensitive,
" and /the\C is always case sensitive
" more: https://vim.fandom.com/wiki/Searching
set ignorecase
set smartcase
set incsearch

"" Tabulator
" insert spaces for tabs
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

"" Relative line numbers
set number relativenumber

"" Highlighting of the search
:nnoremap <silent> <leader>h :nohlsearch<Bar>:echo<CR>

"" Timeout
" default settings for reference
" TO IMPROVE: some mappings no timeouts like [, y, d etc... ?
set timeout timeoutlen=1000

"" Split settings
" splits open at the bottom and right, unlike vim defaults
set splitbelow splitright

"" [Plugin] Gitgutter
" https://github.com/airblade/vim-gitgutter
" smaller value for plugin
set updatetime=500
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gs <Plug>(GitGutterPreviewHunk)

"" Paste Mode toggle
set pastetoggle=<leader>p

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  MOVEMENTS & SEARCH
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Windows navigation
" instead of <C-w>
" split vertically
nnoremap 'v :wincmd v<CR>
" full size
nnoremap 'o :wincmd o<CR>
" top left
nnoremap 'w :wincmd w<CR>
" left
nnoremap 'a :wincmd h<CR>
" up
nnoremap 's :wincmd j<CR>
" down
nnoremap 'd :wincmd k<CR>
" left
nnoremap 'f :wincmd l<CR>
" swap
nnoremap 'x :wincmd x<CR>

"" [Plugin] Vim-markdown
" https://github.com/plasticboy/vim-markdown
" it is installed through vim-polyglot plugin
" maps for reference:
" ]]: go to next header. <Plug>Markdown_MoveToNextHeader
" [[: go to previous header.
" remaps:
" collision with quickfix maps (]c)
nmap [h <Plug>Markdown_MoveToCurHeader
nmap [p <Plug>Markdown_MoveToParentHeader

"" [Plugin] fzf.vim
" https://github.com/junegunn/fzf.vim
" Go to the buffer
nnoremap <Space>bb :Buffers<CR>
"old way: :buffer *
"old way: :ls<CR>:b<Space>

" Open all files from CWD, hidden too (:FilesAll)
command! -bang -nargs=? FilesAll
  \ call fzf#run(fzf#wrap('all-files-in-cwd', {'source': 'find . -type f'}), <bang>0)

" Open file from CWD
nnoremap <C-p> :Files<CR>

" Open file from history
nnoremap <C-A-p> :History<CR>

" Open file from locate
" nnoremap <C-A-l> :Locate

" Extra fzf actions keybindings
function! s:copy_results(lines)
  let joined_lines = join(a:lines, "\n")
  if len(a:lines) > 1
    let joined_lines .= "\n"
  endif
  let @+ = joined_lines
endfunction
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-x': 'split',
  \ 'ctrl-y': function('s:copy_results'),
  \ }

"" qnnb integration
command! -bang -nargs=? Qnnb
  \ call fzf#run(fzf#wrap('qnb-files', {'source': 'ag --follow --ignore .git -g ""', 'dir': '$qnnbPath'}), <bang>0)
nnoremap <Space>bq :Qnnb<CR>

" Ag search with fzf
nnoremap <Space>ag :Ag<CR>
" TODO: tweak command: pass flags

" "" [Plugin] ack.vim
" " Ag search with ack.vim
" if executable('ag')
"   let g:ackprg = 'ag --vimgrep --hidden --follow --ignore .git'
" endif
" cnoreabbrev Ack Ack!
" nnoremap <Space>gh :Ack!<Space>
" nmap <Space>* :Ack! "<cword>"<CR>

"" [Plugin] ctrlsf
" Ag search with ctrlsf
" https://github.com/dyng/ctrlsf.vim
" TODO: test, configure, and compare to ack.vim

"" Search text selected in visual mode
vnoremap // y/<C-R>"<CR>

"" Buffer navigation
" Switch buffers
" saves file if modified - very handy!
nnoremap  <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:b#<CR>

" Remove all buffers but current one
" https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
command! BufDoDelAll silent! execute "%bd|e#"
nnoremap <Space>bda :BufDoDelAll<CR>

" Delete buffer
nnoremap <Space>bd :bd<CR>
" delete all buffers
" use: :bufdo :bd<CR>

" Buffer navigation commands
nnoremap '] :bnext<CR>
nnoremap '[ :bprevious<CR>
"commands for reference
"nnoremap <silent> [B :bfirst<CR>
"nnoremap <silent> ]B :blast<CR>

"" Quickfix window
noremap ]c :cnext<CR>
noremap [c :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

"" Disable arrows
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  EDITS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Paste at the end of line
noremap <Space>P A<space><Esc>p

"" Paste with space at the beginning
noremap <Space>p a<space><Esc>p

"" Paste beneath
noremap <Space>po o<Esc>p

"" Delete action without register
" it uses black hole register
noremap <leader>d "_d

"" Erase line - not removing
nnoremap <Space>C cc<Esc>

"" Yank line but without new line
nnoremap <leader>y ^y$

"" Add space char before cursor in normal mode
nnoremap <leader>j i<space><esc><right>

"" Substitute edits
" replace a word
" use 'c' flag to confirm each change
nnoremap <Space>s *:%s///g<left><left>
" replace a WORD
nnoremap <Space>S :%s/<c-r><c-a>//g<left><left>

"" Quick search and replace
" fast variable rename
" (PV - tip 80)
" to use with .
nnoremap <Space>r *Ncgn

"" Quick search and replace in function
" inside curly braces only
nnoremap <Space>R :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
xnoremap <Space>R :<C-u>'{,'}s/<C-r>=functions#GetVisualSelection()<CR>/

"" Move cursor left in insert mode
" handy with brackets working
inoremap <leader>l <Esc>la

"" Vertically center document when entering Insert mode
" TODO: nnoremap zz
" autocmd InsertEnter * execute "normal zz 10\<C-E>"
"backup: autocmd InsertEnter * norm zz

"" Escape remap
inoremap jk <Esc>

"" Empty lines adding
nnoremap <Space>o mao<Esc>`a
nnoremap <Space>O maO<Esc>`a

"" Matchit activatio for html tags
" when using *
runtime macros/matchit.vim

"" Repeat substitution
" fixing & command (PV - tip 93)
" it is like @ for macros
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"" Closing brackets
" use <C-v> in insert mode to escape it and use single char
" inoremap ' ''<left>  " not often used
inoremap " ""<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <leader>( ()

"" [Plugin] vim-commentary
" see: https://github.com/tpope/vim-commentary
" gcc                   - to comment out a line (takes a count)
" gcap                  - to comment out a paragraph (used with motion)
" gc                    - in visual mode to comment out the selection
" gc                    - in operator pending mode (try-it?) to target a comment
" gcgc                  - uncomments a set of adjacent commented lines
" :7,17Commentary       - as command with range
" :g/TODO/Commentary    - as :global invocation (try-it?)

"" Comment shortcut
" as Ctrl-/
nmap <C-_> gcc

"" Custom read shell command (:R)
" tweak of :r !
" opens  results in new buffer
command! -nargs=* -complete=shellcmd R
			\ new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

"" Auto comments mgmt
" see :h formatoptions
" default vim's value: formatoptions=jcroql (for js files)
" some default vim plugins set above option by default
function! AutoComment()
  exec ':set formatoptions+=cro'
  :set formatoptions?
endfunction
function! AutoCommentOff()
  exec ':set formatoptions-=cro'
  :set formatoptions?
endfunction
command! AutoComment call AutoComment()
command! AutoCommentOff call AutoCommentOff()
map <leader>cmt :set formatoptions-=cro<CR>
map <leader>cmtb :set formatoptions+=cro<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  ABBREVIATIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Common misspellings
:iab konw know
:iab cosnt const

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  FOLDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Folds
" see: https://vim.fandom.com/wiki/Folding
" zo - open 1 fold section
" zc - close 1 fold section
" zr - open 1 more fold level
" zm - close 1 more fold level
" zM - close all folds in the file
" zR - open all folds in the file

"" Toggle Fold shortcut
nnoremap <Enter> za

"" Markdown Folds Expression definition
function MarkdownLevel()
  let h = matchstr(getline(v:lnum), '^#\+')
    if empty(h)
      return "="
    else
      return ">" . len(h)
    endif
endfunction
function! MarkdownFoldText()
    let s:info = '('.string(v:foldend-v:foldstart).' l)'
    let s:line = getline(v:foldstart)
    if strwidth(s:line) > 120 - len(s:info) - 3
        return s:line[:119-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
    else
        return s:line.repeat(' ', 120 - strwidth(s:line) - len(s:info)).s:info
    endif
endfunction
autocmd BufEnter *.md
	\ setlocal foldexpr=MarkdownLevel() |
	\ setlocal foldtext=MarkdownFoldText() |
	\ setlocal foldmethod=expr

"" Autofolding for vim files
" 3 levels of foldings
" see: https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
" defines a foldlevel for each line of code
function! VimFolds(lnum)
  let s:thisline = getline(a:lnum)
  if match(s:thisline, '^"" ') >= 0
    return '>2'
  endif
  if match(s:thisline, '^""" ') >= 0
    return '>3'
  endif
  let s:two_following_lines = 0
  if line(a:lnum) + 2 <= line('$')
    let s:line_1_after = getline(a:lnum+1)
    let s:line_2_after = getline(a:lnum+2)
    let s:two_following_lines = 1
  endif
  if !s:two_following_lines
      return '='
    endif
  else
    if (match(s:thisline, '^"""""') >= 0) &&
       \ (match(s:line_1_after, '^"  ') >= 0) &&
       \ (match(s:line_2_after, '^""""') >= 0)
      return '>1'
    else
      return '='
    endif
  endif
endfunction
" defines a foldtext
function! VimFoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' l)'
  if v:foldlevel == 1
    let s:line = ' ● '.getline(v:foldstart+1)[3:]
  elseif v:foldlevel == 2
    let s:line = '   -> '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = '     ▪ '.getline(v:foldstart)[4:]
  endif
  if strwidth(s:line) > 80 - len(s:info) - 3
    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction
" set foldsettings automatically for vim files
augroup fold_vimrc
  autocmd!
  autocmd FileType vim
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=VimFolds(v:lnum) |
                   \ setlocal foldtext=VimFoldText() |
                   " uncomment if you want see folds in the gutter
                   " no need this but present for reference
                   " \ set foldcolumn=2 foldminlines=2
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  FILE & CWD & UTILS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Highlight refresh for large files
" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim#highlighting-for-large-files
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

"" Path for find command and gf
" for CWD and qnnb
set path=$PWD/**
set path+=$qnnbPath/**

"" Open URL in the browser (gx configuration)
" for linux
" let g:netrw_browsex_viewer="setsid xdg-open"
" for WSL
let g:netrw_browsex_viewer="cmd.exe /C start"

"" Spellcheck
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>
nnoremap <F6> :setlocal spell! spelllang=pl<CR>

"" Save / Save&Close / Quit without save
nnoremap <Space>f :w<CR>
nnoremap <Space>z :x<CR>
nnoremap <Space>q :qa!<CR>
nnoremap <leader>q :q!<CR>
" removed due to lag effect
" use instead: jk + <Space>f
" inoremap <Space>f <Esc>:w<CR>

"" Automatically deletes all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

"" Clipboard configuration for WSL
set clipboard=unnamedplus

"" Rename file (:Mv)
" from: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" some edge cases occured
" alternative:
":sav new_name
":!rm <C-R>#
" form: https://stackoverflow.com/questions/1205286/renaming-the-current-file-in-vim
function! MvFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':!rm ' . old_name
        redraw!
    endif
endfunction
command! Mv call MvFile()

"" Set PWD for current opened file
nnoremap <leader>cdf :cd %:p:h<CR>:pwd<CR>

"" Check PWD for current opened file
nnoremap <leader>cd :pwd<CR>

"" Set PWD to the git project
" or directory of current file if not in git project
" see:  http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction
" follow symlink and set working directory
" TOFIX: not working with git rebase command, so turend off
" some error occurs on the line no. 8 of SetProjectRoot fn?
" autocmd BufRead *
"   \ call FollowSymlink() |
"   \ call SetProjectRoot()
" show CWD at startup of vim and new buffer
 autocmd VimEnter * :pwd
function SetPWDToGit()
     call FollowSymlink() |
     call SetProjectRoot()
     :pwd
endfunction
nnoremap <leader>cdg :call SetPWDToGit()<CR>

"" Undo dir setup
" https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile
" dir may grown up in size TODO: check it in a while
if !isdirectory($HOME."/.cache/vim/undo-dir")
    call mkdir($HOME."/.cache/vim/undo-dir", "", 0770)
endif
set undodir=~/.cache/vim/undo-dir
set undofile

"" Views and Folds save
let g:skipview_files = [
            \ '[EXAMPLE PLUGIN BUFFER]'
            \ ]
function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile'
        " buffer is marked as not a file
        return 0
    endif
    if empty(glob(expand('%:p')))
        " file does not exist on disk
        return 0
    endif
    if len($TEMP) && expand('%:p:h') == $TEMP
        " we're in a temp dir
        return 0
    endif
    if len($TMP) && expand('%:p:h') == $TMP
        " also in temp dir
        return 0
    endif
    if index(g:skipview_files, expand('%')) >= 0
        " file is in skip list
        return 0
    endif
    return 1
endfunction
augroup vimrcAutoView
    autocmd!
    " autosave & Load Views.
    autocmd BufWritePost,BufLeave,WinLeave *.* if MakeViewCheck() | mkview | endif
    autocmd BufWinEnter *.* if MakeViewCheck() | silent! loadview | endif
augroup end

"" Sessions manager (with no plugin used)
let g:sessions_dir = '~/.cache/vim/sessions'
" create session dir if not exists
if !isdirectory($HOME.'/.cache/vim/sessions')
    silent call mkdir ($HOME.'/.cache/vim/sessions', 'p')
endif
exec 'nnoremap ZS :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap ZO :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'
" automatically save the current session whenever vim is closed
autocmd VimLeave * mks! ~/.cache/vim/sessions/quit-session

" Command Abbreviation fn
" borrowed form: Coc
" from: https://github.com/neoclide/coc.nvim/wiki/using-the-configuration-file
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  HOW-TO & Q&A
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Q: How to run nvim with different configuration file?
"  To start vim with custom vimrc file, use:
"     nvim -u <filePath>
"     warn: run without plugins (why?)
"  To start vim without using this .vimrc file, use:
"     nvim -u NORC
"  To start vim without loading any .vimrc or plugins, use:
"     nvim -u NONE

"" Q: How to check settings of nvim?
"  To check all settings for nvim, use:
"     :set all
"  To check status of particular option, use:
"     :set filetype?

"" Q: How to check shortcuts aka map settings in nvim?
"  To check all shortcuts settings, use:
"     :map
"     :nmap
"     :imap
"     :map gc
"  To check all shortcuts settings with additional info, use:
"     :verbose map
"  see: https://vi.stackexchange.com/questions/7722/how-to-debug-a-mapping
"  for common pitfalls

"" Q: How to check current working directory (CWD)?
"  To check current working directory, use:
"     :pwd
"  like: print working directory (PWD)
"  not use :cd, it changes working directory to $HOME

"" Q: How to delete view and swap files?
"  To remove view files, run command in the console:
"     rm -rf ~/.local/share/nvim/view
"  To remove swap files, run command in the console:
"     rm -rf ~/.local/share/nvim/swap

"" Q: How debug option set?
"  To find what overriding option, use:
"     :verbose set tabstop?

"" Q: How to open couple of files in vertical split from terminal?
"  To open files in vertical split, run command in the console:
"     nvim -O file1.md file2.md
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  TEST
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" [Plugin] Coc
" https://github.com/neoclide/coc.nvim

" Status check commands:
" :checkhealth
" :cocinfo

" Config file opens by:
" opens file: coc-settings.json
" :CocConfig

" Open Coc config file (:CC)
call SetupCommandAbbrs('CC', 'CocConfig')

" Not red-highlight comments in the json files
" for coc config file
" https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
autocmd FileType json syntax match Comment +\/\/.\+$+

" Extension list:
let g:coc_global_extensions = [
      \ 'coc-emmet',
      \ 'coc-snippets',
      \ 'coc-eslint',
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-yank',
      \ 'coc-prettier',
      \ 'coc-tsserver'
      \ ]
" above extensions is installed by default.
" to manage it, run:
" :CocList extensions

" Coc completion setup:
" trigger completion and navigate to the next complete item
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <C-n> coc#refresh()

" use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <CR> to confirm completion
" you have to remap <CR> to make sure it confirm completion when pum is visible.
" <C-g>u is used to break undo level
" To make <cr> select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Coc intelisense
" goto code navigation
nmap <Space>td <Plug>(coc-definition)
nmap <Space>ti <Plug>(coc-implementation)
nmap <Space>tf <Plug>(coc-references)

" symbol renaming.
nmap <Space>tr <Plug>(coc-rename)

" Change dir path for plugin installations etc.
" default ~/.config/coc
let g:coc_data_home = '~/.cache/coc'

" [Plugin] coc-prettier
" https://github.com/neoclide/coc-prettier
" to save without formatting, use :noa w

" prettier file command (:priettier and :p)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
call SetupCommandAbbrs('P', 'Prettier')
nnoremap <leader>pr :Prettier<CR>

" [Plugin] coc-eslint
" https://github.com/neoclide/coc-eslint
" navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" apply CodeAction to the current line
nmap <Space>h <Plug>(coc-codeaction)

" apply AutoFix to problem on the current line.
nmap <Space>g <Plug>(coc-fix-current)

" [Plugin] coc-snippets
" https://github.com/neoclide/coc-snippets
" expand and jump
let g:coc_snippet_next = '<Tab>'
imap <C-k> <Plug>(coc-snippets-expand-jump)

" edit snippet file for current filetype
nnoremap <leader>es :CocCommand snippets.editSnippets<CR>

" [Plugin] coc-yank
" https://github.com/neoclide/coc-yank
" change color for plugin's highlight
" TODO: fix it, not working
" hi HighlightedyankRegion term=bold ctermbg=0 guibg=#13354A

" open yank list
nnoremap <silent> <Space>y  :<C-u>CocList -A --normal yank<cr>

" General vim settings recommended in coc readme
" TODO: move to general settings
" from https://github.com/neoclide/coc.nvim#example-vim-configuration
" textedit might fail if hidden is not set.
" set hidden
" when set hidden on - movig buffers behave strange
" how it behaves when using coc?

" some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" give more space for displaying messages.
set cmdheight=2

" don't pass messages to |ins-completion-menu|. (?)
set shortmess+=c

" always show the signcolumn,
" otherwise it would shift the text each time
" diagnostics appear/become resolved. (?)
set signcolumn=yes

