hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "basicsyntax"

hi SpecialKey   cterm=bold          ctermfg=none
hi IncSearch    cterm=reverse       ctermfg=none
hi Search       cterm=reverse       ctermfg=none
hi MoreMsg      cterm=bold          ctermfg=none
hi ModeMsg      cterm=bold          ctermfg=none
hi LineNr       cterm=none          ctermfg=3
hi StatusLine   cterm=bold,reverse  ctermfg=none
hi StatusLineNC cterm=reverse       ctermfg=none
hi VertSplit    cterm=reverse       ctermfg=none
hi Title        cterm=bold          ctermfg=none
hi Visual       cterm=reverse       ctermfg=none
hi VisualNOS    cterm=bold          ctermfg=none
hi WarningMsg   cterm=standout      ctermfg=none
hi WildMenu     cterm=standout      ctermfg=none
hi Folded       cterm=standout      ctermfg=none
hi FoldColumn   cterm=standout      ctermfg=none
hi DiffAdd      cterm=bold          ctermfg=none
hi DiffChange   cterm=bold          ctermfg=none
hi DiffDelete   cterm=bold          ctermfg=none
hi DiffText     cterm=reverse       ctermfg=none
hi Type         cterm=none          ctermbg=none ctermfg=none
hi Keyword      cterm=none          ctermbg=none ctermfg=none
hi Number       cterm=none          ctermbg=none ctermfg=none
hi Char         cterm=none          ctermbg=none ctermfg=none
hi Format       cterm=none          ctermbg=none ctermfg=none
hi Special      cterm=bold          ctermbg=none ctermfg=0
hi Constant     cterm=none          ctermbg=none ctermfg=none
hi PreProc      cterm=bold          ctermfg=0
hi Directive    cterm=none          ctermbg=none ctermfg=none
hi Conditional  cterm=none          ctermbg=none ctermfg=none
hi Comment      cterm=none          ctermbg=none ctermfg=6
hi Func         cterm=none          ctermbg=none ctermfg=none
hi Identifier   cterm=none          ctermbg=none ctermfg=none
hi Statement    cterm=none          ctermbg=none ctermfg=none
hi Ignore       cterm=bold          ctermfg=none
hi String       cterm=bold          ctermfg=0
hi ErrorMsg     cterm=reverse       ctermfg=9    ctermbg=15
hi Error        cterm=reverse       ctermfg=9    ctermbg=15
hi Todo         cterm=bold,standout ctermfg=11   ctermbg=0
hi MatchParen   cterm=bold          ctermfg=none ctermbg=6
hi ColorColumn  ctermbg=none
