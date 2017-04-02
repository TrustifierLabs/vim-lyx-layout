" Vim syntax file
" Language: LyX layout/module files
" Author: Ahmed Masud <ahmed.masud@trustifier.com>
" License: MIT / See LICENSE for details

func! s:FTLyXModule()
	let n = 1
	while n < 10 && n < line("$")
		let line = getline(n)
		let is_lyxlayout = line =~ '\\DeclareLaTeXClass'
		let is_lyxmodule = line =~ '\\DeclareLyXModule'
		let is_lyxinclude = line =~ 'LyXModuleInclude'
		if is_lyxlayout || is_lyxmodule || is_lyxinclude
			setlocal filetype=lyx-layout
			return 
		endif
		let n = n+1
	endwhile
endfun

autocmd BufRead,BufNewFile *.layout,*.module,*.inc call s:FTLyXModule()
