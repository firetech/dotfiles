"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:config = vue#GetConfig('config', {})
let s:attribute = s:config.attribute
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Syntax highlight {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clear htmlHead that may cause highlighting out of bounds
silent! syntax clear htmlHead

" html5 data-*
syntax match htmlArg '\v<data(-[.a-z0-9]+)+>' containedin=@html

" Vue ref attribute
syntax match htmlArg 'ref' containedin=@html

" Use syn-match in order to highlight both transition and transition-group
" according to syn-priority
syntax match VueComponentName containedin=htmlTagN '\v(component|slot|transition)' 
syntax match VueComponentName containedin=htmlTagN '\v\C<[a-z0-9]+(-[a-z0-9]+)+>'
syntax match VueComponentName containedin=htmlTagN '\v\C<([A-Z][a-zA-Z0-9]+)+>'

syntax match VueAttr '\v(\S)@<![v:\@][^=/>[:blank:]]+(\=\"[^"]*\")?' 
      \ keepend
      \ containedin=htmlTag 
      \ contains=VueKey,VueQuote

syntax match VueKey contained '\v[v:\@][^=/>[:blank:]]+'
syntax region VueQuote contained 
      \ start='"' end='"' 
      \ contains=VueValue

syntax match VueInject contained '\v\$\w*'

syntax region VueExpression 
      \ containedin=ALLBUT,htmlComment
      \ matchgroup=VueBrace
      \ transparent
      \ start="{{"
      \ end="}}"

" Just to avoid error when using pattern in containedin
syntax match htmlTemplateBlock /htmlTemplateBlock/
syntax region VueExpression 
      \ containedin=VueValue,htmlString,htmlValue,.*TemplateBlock,html.*Block
      \ contains=@simpleJavascriptExpression
      \ matchgroup=VueBrace
      \ start="{{"
      \ end="}}"

" Transition attributes
syntax match htmlArg contained "\<\(enter-from-class\|enter-active-class\|enter-to-class\|leave-from-class\|leave-active-class\|leave-to-class\)\>"

" Wepy directive syntax
syntax match VueAttr '\v(\S)@<!wx[^\=>[:blank:]]+(\=\"[^"]*\")?'
      \ containedin=htmlTag  
      \ contains=VueKey,VueQuote

" Mini program syntax
syntax match VueKey contained '\vwx[^\=>[:blank:]]+'
syntax match VueCustomTag containedin=htmlTagN '\v<(view|text|block|image|checkbox|radio)>'

syntax cluster simpleJavascriptExpression contains=\CjavaScript.*

" JavaScript syntax
syntax region javaScriptStringS	
      \ start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contained
syntax region javaScriptStringD	
      \ start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contained
syntax region javaScriptTemplateString
      \ start=+`+ skip=+\\`+  end=+`|$+ contained
      \ contains=javaScriptTemplateExpression
syntax region javaScriptTemplateExpression
      \ matchgroup=VueBrace
      \ start=+${+ end=+}+ contained
      \ contains=@simpleJavascriptExpression

syntax keyword htmlTagName contained template script style

highlight default link VueAttr htmlTag
if s:attribute
  syntax match VueValue contained '\v\"\zs[^"]+\ze\"'
        \ contains=VueInject,@simpleJavascriptExpression
  highlight default link VueKey Type
  highlight default link VueQuote VueAttr
  highlight default link VueValue None
else
  syntax match VueValue contained '\v\"\zs[^"]+\ze\"'
  highlight default link VueKey htmlArg
  highlight default link VueQuote String
  highlight default link VueValue String
endif
highlight default link VueInject Constant
highlight default link VueBrace Type
highlight default link VueComponentName htmlTagName
highlight default link VueCustomTag htmlTagName
highlight default link javaScriptStringS String
highlight default link javaScriptStringD String
highlight default link javaScriptTemplateString String
highlight default link javaScriptNumber	Constant
highlight default link htmlJavaScriptOperator	Operator
"}}}
" vim: fdm=marker
