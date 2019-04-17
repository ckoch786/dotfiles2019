set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'luochen1990/rainbow'
Plugin 'vim-scripts/Visual-Studio' "<- Color Theme. On update comment out font at bottom of visualstudio.vim
Plugin 'tomtom/tcomment_vim'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" 
"""""""""""""""""""""""""""""""""""""""""""
" An example for a gvimrc file.
" The commands in this are executed when the GUI is started, after the vimrc
" has been executed.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Apr 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95

endif



" Local settings file, default to linux
" let s:localFile = "~/.local.vim" 

" Know the platform we're running on
function! GetPlatform()
    if has("win32") || has("win64")
        return "win"
    else
        return "nix"
    endif
endfunction
 
" Get ready for life w/o walls
if GetPlatform() == "win"
    " let s:localFile = "~/local.vim"
    let g:skip_loading_mswin = 1    " don't need the shortcuts
    behave mswin
endif

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h13:cANSI
  endif
endif

" For opening Vim in visual studio see: https://vim.fandom.com/wiki/Integrate_gvim_with_Visual_Studio
" --servername gVimStudio2019 --remote-silent +"execute 'normal! $(CurLine)G$(CurCol)|'" "$(ItemPath)" 
" --servername gVimStudio --remote-silent +"execute 'normal! $(CurLine)G$(CurCol)|'" "$(ItemPath)" 

" Set spacing according to project working on:
" For RosterApps: 
"   web all HTML is 2 spaces for tabs as spaces
"       setlocal ts=2 sts=2 sw=2 expandtab
"   For all JS 4 space tabs as spaces
"       setlocal ts=4 sts=4 sw=4 expandtab
" For Mobile App:
"   All code 4 spaces for tabs as tabs or spaces can be mixed
"       setlocal ts=4 sts=4 sw=4 expandtab


nnoremap ,r :call RosterApps()<CR>
function! RosterApps()
    " Only do this part when compiled with support for autocommands
    if has("autocmd")
      " Enable file type detection
      " TODO  how  does this effect the first lines? filetype on

      " Syntax of these languages is fussy over tabs Vs spaces
      autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
      autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    "" if Roster Apps:
      " Customisations based on house-style (arbitrary)
      autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
      autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab 

      " Treat .apsx files as html 
      autocmd BufNewFile,BufRead *.aspx setfiletype html 
    endif
endfunction 

nnoremap ,m : call Mobile()<CR>
function! Mobile()
    " Only do this part when compiled with support for autocommands
    if has("autocmd")
      " Enable file type detection
        " TODO see RosterApps filetype on
        autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
        autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
        autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
    endif
endfunction
" END Set spacing according to project working on:
"""""""""""""""
""""""" Plugin settings """"""""""" 
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
colorscheme visualstudio " Commented out last line for missing font

""set runtimepath^=~\vimfiles\bundle\ctrlp.vim

""""""""" Personal Settings """"""""

" Saving files
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>

" on v.s. enable??
" on overrides your color settings, 
" enable leaves your color settings alone
syntax enable
" set at top? filetype plugin on
:set guioptions -=T " remove the toolbar
":set guioptions -=m remove the menu

set ruler
set laststatus=2  " Always show status line.
" Highlight the status line
""highlight StatusLine ctermfg=blue ctermbg=yellow
set relativenumber
" https://shapeshed.com/vim-statuslines/
set statusline=
" leading 0 below is overridden by '-'
"%-0{minwid}.{maxwid}{item}
set statusline+=%2*%-10.3n\ " buffer number "- left justify item, default is right
set statusline+=%2*%f\ " filename
" # - highlight groups %#HLname#
set statusline+=%2*%#PmenuSel#
set statusline+=%2*%#LineNr#
set statusline+=%2*%m " modified flag [+] or [-]
set statusline+=%= " Right side of line
set statusline+=%2*%#CursorColumn#
set statusline+=%2*\ %p%% "Percentage of lines in file line CTRL-G
set statusline+=%2*\ %l:%c "l-line number, c-column number
set statusline+=%2*\ "space"

hi User1 guifg=#FFFFFF guibg=#191f26 gui=BOLD
hi User2 guifg=#000000 guibg=#959ca6 " use %2* to use
hi User3 guifg=#000000 guibg=#4cbf99


"autocmd FileType html setlocal commentstring=<!-- \ %s

" Scratch buffer
":setlocal buftype=nofile
":setlocal bufhidden=hide
":setlocal noswapfile

" start github.com/mcantor/no_plugins 
" FEATURES TO COVER:
" - Fuzzy File Search
" - Tag jumping
" - Autocomplete
" - File Browsing
" - Snippets
" - Build Integration (if we have time)

" {{{ BASIC SETUP
" BASIC SETUP:

" enter the current millenium
set nocompatible

" enable syntax and plugins (for netrw)
""syntax enable
"filetype plugin on

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" SNIPPETS:

" Read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" BUILD INTEGRATION:

" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix

" Configure the `make` command to run RSpec
"set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back
"
" end github.com/mcantor/no_plugins 
