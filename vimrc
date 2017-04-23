" Basics {
    set nocompatible " explicitly get out of vi-compatible mode
    set background=dark " we plan to use a dark background
    syntax on " syntax highlighting on
" }

" General {
   filetype on
   filetype plugin on " load filetype plugins settings
   filetype indent on " load filetype indent settings
   set backspace=indent,eol,start " make backspace a little more flexible
   set backup " make backup files
   set backupdir=~/tmp " where to put backup files
   set directory=~/tmp " directory to place swap files in
   set fileformats=unix,mac,dos " support all three, in this order
   set hidden " you can change buffers without saving
   set iskeyword+=_,$,@,%,# " none of these are word dividers
   set mouse=a " use mouse everywhere
   set noerrorbells " don't make noise
   set visualbell " flash on error
   set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
   set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png " ignore these
   set wildmenu " turn on command line completion
   set wildmode=list:longest " turn on wild menu with very large list
   set grepprg=grep\ -nH\ $*
   set enc=utf-8
" }

" Vim UI {
   set cursorcolumn " highlight the current column
   set cursorline " highlight current line
   set incsearch " highlight as you type you search phrase
   set laststatus=2 " always show the status line
   set lazyredraw " do not redraw while running macros
   set linespace=0 " don't insert any extra pixel lines betweens rows
   set list " we do what to show tabs, to ensure we get them out of my files
   set listchars=tab:>-,trail:- " show tabs and trailing whitespace
   set matchtime=5 " how many tenths of a second to blink matching brackets for
   set hlsearch " highlight searched for phrases
   set nostartofline " leave my cursor where it was
   set novisualbell " don't blink
   set number " turn on line numbers
   set numberwidth=5 " We are good up to 99999 lines
   set report=0 " tell us when anything is changed via :...
   set ruler " Always show current positions along the bottom
   set scrolloff=10 " Keep 5 lines (top/bottom) for scope
   set shortmess=atI " shortens messages to avoid 'press a key' prompt
   set showcmd " show the command being typed
   set showmatch " show matching brackets
   set sidescrolloff=10 " Keep 5 lines at the size
   function! SyntaxItem()
      return synIDattr(synID(line("."),col("."),1),"name")
   endfunction
   if has('statusline')
      set statusline=%#Question#                   " set highlighting
      set statusline+=%-2.2n\                      " buffer number
      set statusline+=%#WarningMsg#                " set highlighting
      set statusline+=%F\                          " file name
      set statusline+=%#Question#                  " set highlighting
      set statusline+=%h%m%r%w\                    " flags
      set statusline+=%{strlen(&ft)?&ft:'none'},   " file type
      set statusline+=%{(&fenc==\"\"?&enc:&fenc)}, " encoding
      set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")} " BOM
      set statusline+=%{&fileformat},              " file format
      set statusline+=%{&spelllang},               " language of spelling checker
      set statusline+=%{SyntaxItem()}              " syntax highlight group under cursor
      set statusline+=%=                           " ident to the right
      set statusline+=\%03.3b\                     " ASCII code under cursor
      set statusline+=0x%-8B\                      " character code under cursor
      set statusline+=%-7.(%l,%c%V%)\ %<%P\        " cursor position/offset
      set statusline+=%L
   endif

   " statusline demo: ~\myfile[+] [FORMAT=format] [TYPE=type] [ASCII=000] [HEX=00] [POS=0000,0000][00%] [LEN=000]
   "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
" }

" Text Formatting/Layout {
   set completeopt=menu,longest " improve the way autocomplete works
   set expandtab " no real tabs please!
   set formatoptions=rq " Automatically insert comment leader on return, and let gq work
   set ignorecase " case insensitive by default
   set nowrap " do not wrap line
   set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
   set smartcase " if there are caps, go case-sensitive
   " Indent Related {
      set shiftwidth=4 " unify
      set softtabstop=4 " unify
      set tabstop=4 " real tabs should be 4, but they will show with set list on
   " }
" }

" Folding {
   set foldenable " Turn on folding
   set foldmarker={,} " Fold C style code (useful with high foldlevel)
   set foldmethod=marker " Fold on the marker
   set foldlevel=100 " Don't autofold anything (but I can still fold manually)
   set foldopen=block,hor,mark,percent,quickfix,tag " what movements to open folds on
" }

" Plugin Settings {
   source $VIMRUNTIME/macros/matchit.vim


   let b:match_ignorecase = 1 " case is stupid
   let perl_extended_vars=1 " highlight advanced perl vars inside strings

   " NERDTree Settings {
      let NERDChristmasTree = 1
      let NERDTreeChDirMode = 2
      let NERDTreeHighlightCursorline = 1
      let NERDTreeQuitOnOpen = 1
      let NERDTreeShowBookmarks = 1
      let NERDTreeWinPos = "left"
      let NERDTreeWinSize = 38
   " }

   " TagList Settings {
      let Tlist_Auto_Open=0 " let the tag list open automagically
      let Tlist_Compact_Format = 1 " show small meny
      let Tlist_Ctags_Cmd = 'ctags' " location of ctags
      let Tlist_Enable_Fold_Column = 0 " do show folding tree
      let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
      let Tlist_File_Fold_Auto_Close = 1 " fold closed other trees
      let Tlist_Sort_Type = "name" " order by
      let Tlist_Use_Right_Window = 1 " split to the right side of the screen
      let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always) read my functions
      " Langauge Specifics {
         let tlist_aspjscript_settings = 'asp;f:function;c:class' " functions/classes
         let tlist_aspvbs_settings = 'asp;f:function;s:sub' " functions/subs
         let tlist_php_settings = 'php;c:class;d:constant;f:function' " no variables
         let tlist_vb_settings = 'asp;f:function;c:class' " functions/classes
      " }
   " }
" }

" Mappings {
   " F Keys {
      "map <F1>
      map <F2> :NERDTreeToggle<CR>
      map <F3> :BufExplorer<CR>
      map <F4> :TlistToggle<CR>
      "map <F5>
      map <F6> :Calendar<CR>
      "map <F7> 
      "map <F8> 
      map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
      "map <F10> 
      "map <F11> 
      map <F12> ggVGg?
   " }
   noremap <S-space> <C-b>
   noremap <space> <C-f>

   nnoremap ,t <C-]>
   nnoremap ,T <C-O>

   nnoremap ,H yyp^v$r-o<Esc>

   map ,w <C-w>w
   map ,b :bn<CR>

   nmap ,s :source $MYVIMRC
   nmap ,v :e $MYVIMRC<CR>

   map \n viw<ESC>b~
   
   nmap ,o o<ESC>
   nmap ,O O<ESC>


   " Make Arrow Keys Useful {
      "map <down> <ESC>:bn<RETURN> 
      "map <left> <ESC>:NERDTreeToggle<RETURN>
      "map <right> <ESC>:Tlist<RETURN>
      "map <up> <ESC>:bp<RETURN>
   " }
   
   map ,cd :cd %:p:h<CR>

" }

" Autocommands {
   autocmd BufNewFile,BufRead *.pl set filetype=prolog
   autocmd BufNewFile,BufRead *.pl set syntax=prolog
   autocmd BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2 " ruby standard 2 spaces, always
   autocmd BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2 " ...
   autocmd BufRead,BufNewFile *.rb,*.rhtml set tabstop=2 " ...
   " Notes {
      " I consider .notes files special, and handle them differently
      autocmd BufRead,BufNewFile *.notes set foldlevel=1
      autocmd BufRead,BufNewFile *.notes set foldmethod=indent
      autocmd BufRead,BufNewFile *.notes set foldtext=foldtext()
      autocmd BufRead,BufNewFile *.notes set listchars=tab:\ \
      autocmd BufRead,BufNewFile *.notes set noexpandtab
      autocmd BufRead,BufNewFile *.notes set shiftwidth=1
      autocmd BufRead,BufNewFile *.notes set softtabstop=1
      autocmd BufRead,BufNewFile *.notes set syntax=notes
      autocmd BufRead,BufNewFile *.notes set tabstop=1
   " }
" }

" GUI Settings {
if has("gui")
   " Basics {
      "colorscheme zenburn " 
      set columns=140 " perfect size for me
      set guifont=Monaco:h14 "
      "set guifont=Inconsolata:h14 "
      set guioptions=c " use simple dialogs rather than pop-ups
      set lines=50 " perfect size for me
      set mousehide " hide the mouse cursor when typing
   " }

   " Font Switching Binds {
      map <F10> <ESC>:set guifont=Monaco:h14<CR>
      map <F11> <ESC>:set guifont=Monaco:h16<CR>
      map <F12> <ESC>:set guifont=Monaco:h20<CR>
   " }

   map ,ff :set lines=67<CR>:set columns=237<CR>

endif
" }


" Functions {
    " Moving Lines/Visual {
        function! MoveLineUp()
            call MoveLineOrVisualUp(".", "")
        endfunction

        function! MoveLineDown()
            call MoveLineOrVisualDown(".", "")
        endfunction

        function! MoveVisualUp()
            call MoveLineOrVisualUp("'<", "'<,'>")
            normal gv
        endfunction

        function! MoveVisualDown()
            call MoveLineOrVisualDown("'>", "'<,'>")
            normal gv
        endfunction

        function! MoveLineOrVisualUp(line_getter, range)
            let l_num = line(a:line_getter)
            if l_num - v:count1 - 1 < 0
                let move_arg = "0"
            else
                let move_arg = a:line_getter." -".(v:count1 + 1)
            endif
            call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
        endfunction

        function! MoveLineOrVisualDown(line_getter, range)
            let l_num = line(a:line_getter)
            if l_num + v:count1 > line("$")
                let move_arg = "$"
            else
                let move_arg = a:line_getter." +".v:count1
            endif
            call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
        endfunction

        function! MoveLineOrVisualUpOrDown(move_arg)
            let col_num = virtcol(".")
            execute "silent! ".a:move_arg
            execute "normal! ".col_num."|"
        endfunction

        nnoremap <silent> <C-Up> :<C-u>call MoveLineUp()<CR>
        nnoremap <silent> <C-Down> :<C-u>call MoveLineDown()<CR>
        inoremap <silent> <C-Up> <C-o>:<C-u>call MoveLineUp()<CR>
        inoremap <silent> <C-Down> <C-o>:<C-u>call MoveLineDown()<CR>
        vnoremap <silent> <C-Up> :<C-u>call MoveVisualUp()<CR>
        vnoremap <silent> <C-Down> :<C-u>call MoveVisualDown()<CR>
    " }
" }
