
" Vim color file
" Maintainer:   Jani Nurminen <jani.nurminen@intellitel.com>
" Last Change:	$Id: zenburn.vim,v 1.13 2002/09/16 18:03:49 jnurmine Exp $
" URL:		Not yet...
" License:      GPL
"
" Nothing too fancy, just some alien fruit salad to keep you in the zone.
" This syntax file was designed to be used with dark environments and 
" low light situations. Of course, if it works during a daybright office, go
" ahead :)
"
" Owes heavily to other Vim color files! With special mentions
" to "BlackDust", "Camo" and "Desert".
"
" To install, copy to ~/.vim/colors directory. Then :colorscheme zenburn.  
" See also :help syntax
"
" CONFIGURABLE PARAMETERS:
" 
" You can use the default (don't set any parameters), or you can
" set some parameters to tweak the Zenlook colours.
"
" * To get more contrast to the Visual selection, use
"   
"      let g:zenburn_alternate_Visual = 1
" 
" * To use alternate colouring for Error message, use
"     
"      let g:zenburn_alternate_Error = 1
"
" * The new default for Include is a duller orang.e To use the original
"   colouring for Include, use
"     
"      let g:zenburn_alternate_Include = 1
"
" * To turn the parameter(s) back to defaults, use unlet.
"
" That's it, enjoy!
" 
" TODO
"   - IME colouring (CursorIM)
"   - obscure syntax groups: check and colourize
"   - add more groups if necessary

set background=dark
hi clear          
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="jjcolors"

hi Boolean         guifg=#dca3a3
hi Character       guifg=#dca3a3 gui=bold
hi Comment         guifg=#7f9f7f
hi Conditional     guifg=#f0dfaf gui=bold
hi Constant        guifg=#dca3a3 gui=bold
hi Cursor          guifg=#000d18 guibg=#8faf9f gui=bold
hi Debug           guifg=#dca3a3 gui=bold
hi Define          guifg=#ffcfaf gui=bold
hi Delimiter       guifg=#8f8f8f
hi DiffAdd         guifg=#709080 guibg=#313c36 gui=bold
hi DiffChange      guibg=#333333
hi DiffDelete      guifg=#333333 guibg=#464646
hi DiffText        guifg=#ecbcbc guibg=#41363c gui=bold
hi Directory       guifg=#dcdccc gui=bold
hi ErrorMsg        guifg=#60b48a guibg=#3f3f3f gui=bold
hi Exception       guifg=#c3bf9f gui=bold
hi Float           guifg=#c0bed1
hi FoldColumn      guifg=#93b3a3 guibg=#3f4040
hi Folded          guifg=#93b3a3 guibg=#3f4040
hi Function        guifg=#efef8f
hi Identifier      guifg=#efdcbc
hi IncSearch       guibg=#f8f893 guifg=#385f38
hi Keyword         guifg=#f0dfaf gui=bold
hi Label           guifg=#dfcfaf gui=underline
hi LineNr          guifg=#7f8f8f guibg=#464646
hi Macro           guifg=#ffcfaf gui=bold
hi ModeMsg         guifg=#ffcfaf gui=none
hi MoreMsg         guifg=#ffffff gui=bold
hi NonText         guifg=#404040
hi Normal          guifg=#dcdccc guibg=#3f3f3f
hi Number          guifg=#8cd0d3
hi Operator        guifg=#f0efd0
hi PreCondit       guifg=#dfaf8f gui=bold
hi PreProc         guifg=#ffcfaf gui=bold
hi Question        guifg=#ffffff gui=bold
hi Repeat          guifg=#ffd7a7 gui=bold
hi Search          guifg=#ffffe0 guibg=#385f38
hi SpecialChar     guifg=#dca3a3 gui=bold
hi SpecialComment  guifg=#82a282 gui=bold
hi Special         guifg=#cfbfaf
hi SpecialKey      guifg=#9ece9e
hi Statement       guifg=#e3ceab guibg=#3f3f3f gui=none
hi StatusLine      guifg=#1e2320 guibg=#acbc90
hi StatusLineNC    guifg=#2e3330 guibg=#88b090
hi StorageClass    guifg=#c3bf9f gui=bold
hi String          guifg=#cc9393
hi Structure       guifg=#efefaf gui=bold
hi Tag             guifg=#dca3a3 gui=bold
hi Title           guifg=#efefef guibg=#3f3f3f gui=bold
hi Todo            guifg=#7faf8f guibg=#3f3f3f gui=bold
hi Typedef         guifg=#dfe4cf gui=bold
hi Type            guifg=#dfdfbf gui=bold
hi Underlined      guifg=#dcdccc guibg=#3f3f3f gui=underline
hi VertSplit       guifg=#303030 guibg=#688060
hi VisualNOS       guifg=#333333 guibg=#f18c96 gui=bold,underline
hi WarningMsg      guifg=#ffffff guibg=#333333 gui=bold
hi WildMenu        guibg=#2c302d guifg=#cbecd0 gui=underline

if exists("g:zenburn_alternate_Visual")
    " Visual with more contrast, thanks to Steve Hall & Cream posse
    hi Visual          guifg=#000000 guibg=#71d3b4
else
    " use default visual
    hi Visual          guifg=#233323 guibg=#71d3b4
endif

if exists("g:zenburn_alternate_Error")
    " use a bit different Error
    hi Error           guifg=#ef9f9f guibg=#201010 gui=bold  
else
    " default
    hi Error           guifg=#e37170 guibg=#332323 gui=none
endif

if exists("g:zenburn_alternate_Include")
    " original setting
    hi Include         guifg=#ffcfaf gui=bold
else
    " new, less contrasted one
    hi Include         guifg=#dfaf8f gui=bold
endif
    " TODO check every syntax group that they're ok


hi Normal           cterm=NONE      ctermfg=58      ctermbg=187
hi Cursor           cterm=NONE      ctermfg=230     ctermbg=58
hi CursorLine       cterm=NONE      ctermfg=NONE    ctermbg=186
hi CursorColumn     cterm=NONE      ctermfg=NONE    ctermbg=185
hi Incsearch        cterm=NONE      ctermfg=58      ctermbg=174
hi Search           cterm=NONE      ctermfg=58      ctermbg=174
hi ErrorMsg         cterm=NONE      ctermfg=58      ctermbg=197
hi WarningMsg       cterm=NONE      ctermfg=58      ctermbg=226
hi ModeMsg          cterm=NONE      ctermfg=58      ctermbg=192
hi MoreMsg          cterm=NONE      ctermfg=58      ctermbg=154
hi Question         cterm=NONE      ctermfg=27      ctermbg=NONE
hi StatusLine       cterm=NONE      ctermfg=187     ctermbg=30
hi StatusLineNC     cterm=NONE      ctermfg=58      ctermbg=101
hi User1            cterm=NONE      ctermfg=28      ctermbg=NONE
hi User2            cterm=NONE      ctermfg=39      ctermbg=NONE
hi VertSplit        cterm=NONE      ctermfg=144     ctermbg=144
hi WildMenu         cterm=NONE      ctermfg=58      ctermbg=144
hi DiffText         cterm=NONE      ctermfg=58      ctermbg=190
hi DiffChange       cterm=NONE      ctermfg=58      ctermbg=83
hi DiffDelete       cterm=NONE      ctermfg=187     ctermbg=124
hi DiffAdd          cterm=NONE      ctermfg=187     ctermbg=21
hi Folded           cterm=NONE      ctermfg=19      ctermbg=115
hi FoldedColumn     cterm=NONE      ctermfg=39      ctermbg=190
hi FoldColumn       cterm=NONE      ctermfg=19      ctermbg=115
hi Directory        cterm=NONE      ctermfg=28      ctermbg=NONE
hi LineNr           cterm=NONE      ctermfg=58      ctermbg=144
hi NonText          cterm=NONE      ctermfg=58      ctermbg=144
hi SpecialKey       cterm=NONE      ctermfg=130     ctermbg=NONE
hi Title            cterm=NONE      ctermfg=19      ctermbg=NONE
hi Visual           cterm=NONE      ctermfg=58      ctermbg=192
hi Comment          cterm=NONE      ctermfg=101     ctermbg=NONE
hi Constant         cterm=NONE      ctermfg=131     ctermbg=NONE
hi String           cterm=NONE      ctermfg=23      ctermbg=NONE
hi Error            cterm=NONE      ctermfg=197     ctermbg=NONE
hi Identifier       cterm=NONE      ctermfg=24      ctermbg=NONE
hi Ignore           cterm=NONE      ctermfg=187     ctermbg=NONE
hi Number           cterm=NONE      ctermfg=22      ctermbg=NONE
hi PreProc          cterm=NONE      ctermfg=52      ctermbg=NONE
hi Special          cterm=NONE      ctermfg=22      ctermbg=NONE
hi SpecialChar      cterm=NONE      ctermfg=88      ctermbg=NONE
hi Statement        cterm=NONE      ctermfg=89      ctermbg=NONE
hi Todo             cterm=NONE      ctermfg=58      ctermbg=156
hi Type             cterm=NONE      ctermfg=53      ctermbg=NONE
hi Underlined       cterm=UNDERLINE ctermfg=NONE    ctermbg=NONE
hi TaglistTagName   cterm=NONE      ctermfg=29      ctermbg=118

