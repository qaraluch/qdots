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
" Plug 'mileszs/ack.vim'																"https://github.com/mileszs/ack.vim
Plug 'dyng/ctrlsf.vim'																	"https://github.com/dyng/ctrlsf.vim
Plug 'tpope/vim-commentary'                             "https://github.com/tpope/vim-commentary
Plug 'sheerun/vim-polyglot'				                      "https://github.com/sheerun/vim-polyglot
" Plug 'arcticicestudio/nord-vim' 			                "https://github.com/arcticicestudio/nord-vim
Plug 'dracula/vim', { 'as': 'dracula' }			            "https://github.com/dracula/vim
Plug 'airblade/vim-gitgutter'                           "https://github.com/airblade/vim-gitgutter
Plug 'w0rp/ale'																					"https://github.com/dense-analysis/ale
Plug 'tpope/vim-surround'																"https://github.com/tpope/vim-surround
Plug 'itchyny/lightline.vim'                            "https://github.com/itchyny/lightline.vim
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
"" Leader key
" No need for leader key!
" Disadvantage is that it is also used in insert mode,
" so it cause lag effect
" Use default one: \
" - for special, not common command
" Used mental leader key: <Space>
" - for common command like ???
" Used mental leader key: ,
" - for ???
" Used mental leader key: '
" - for ???
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
nnoremap <silent> <Space>] :bnext<CR>
nnoremap <silent> <Space>[ :bprevious<CR>
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
noremap <Space>d "_d

"" Erase line - not removing
nnoremap <Space>C cc<Esc>

"" Yank line but without new line
nnoremap <Space>y ^y$

"" Add space char before cursor in normal mode
nnoremap <leader>j i<space><esc><right>

"" Substitute edits
" replace a word
" use 'c' flag to confirm each change
nnoremap <Space>s *:%s///g<left><left>
" replace a WORD
nnoremap <Space>S :%s/<c-r><c-a>//g<left><left>

"" Fast variable rename
" (PV - tip 80)
" to use with .
nnoremap <Space>r *Ncgn

"" Move cursor left in insert mode
" handy with brackets working
inoremap <leader>; <Esc>la

"" Vertically center document when entering Insert mode
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
"" Path for find command
" for CWD and qnnb
set path=$PWD/**
set path+=$qnnbPath/**

"" Open URL in the browser (gx configuration)
" for linux
" let g:netrw_browsex_viewer="setsid xdg-open"
" for WSL
let g:netrw_browsex_viewer="cmd.exe /C start"

"" [Plugin] Ale
" https://github.com/dense-analysis/ale
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
let b:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1
nmap <F7> <Plug>(ale_fix)

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
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

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
"  To check all shorcuts settings, use:
"     :map
"     :nmap
"     :imap
"     :map gc
"  To check all shorcuts settings with additional info, use:
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
"  TEST SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
