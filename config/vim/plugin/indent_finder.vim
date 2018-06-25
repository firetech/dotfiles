augroup IndentFinder
	au! IndentFinder
	au BufRead * execute system('test -x "`which python`" && python ~/.vim/plugin/indent_finder.py --vim-output "' . expand('%') . '"' )
augroup End
