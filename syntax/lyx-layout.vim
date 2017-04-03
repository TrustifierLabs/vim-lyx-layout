" vim syntax file for lyx layouts and modules
" Copyright (C) 2017 Ahmed Masud <ahmed.masud@trustifier.com>
" Released under the same license as other vim syntax files
" 


if version < 600
	syntax clear
else
	if exists('b:current_syntax') | finish | endif 
endif

syntax include @lyxTeX 	syntax/tex.vim 
unlet b:current_syntax
syntax include @lyxHTML syntax/xhtml.vim

syntax case ignore

syntax region lyxComment start=+#+ end=+$+ contains=lyxHeader contained containedin=ALLBUT,lyxPreamble,lyxHTMLPreamble,lyxHeader.*

syntax keyword lyxKeywords
	\ End
	\ Input
	\ InsetLayout 

syntax keyword lyxHeaderKeywords contained 
	\ LyXModuleInclude
	\ DeclareLyXModule 
	\ EndLyXDeclaration 
	\ EndDeclaration

syntax keyword lyxHeaderDescriptionKW contained containedin=lyxComment
	\ DescriptionBegin
	\ DescriptionEnd 


syntax keyword lyxPreambleKeywords contained
	\ AddToHTMLPreamble
	\ AddToPreamble
	\ HTMLPreamble
	\ Preamble
	\ EndPreamble

syntax region lyxHeader
	\ start=/^#\s*\(\(\\DeclareLyXModule\)\|\(LyXModuleInclude\)\)/
	\ end=/^\s*$\|^\s[^#]*$\|^#End\(LyX\)?Declaration/
	\ contains=lyxHeaderDescription,lyxHeaderKeywords

syntax region lyxHeaderDescription contained containedin=lyxHeader
	\ matchgroup=lyxHeaderDescriptionKW
	\ start=/\v^#\s*DescriptionBegin/
	\ end=/\v^#\s*DescriptionEnd/
	\ contains=lyxHeaderDescriptionLine,lyxHeaderDescriptionKW,lyxHeaderParams

syntax region lyxHeaderDescriptionLine contained containedin=lyxHeaderDescription
	\ start=+^#+ end=+$+ 


syntax match lyxHeaderParamLine /\v:.*/ contained containedin=lyxHeader

syntax match lyxHeaderParamOpers /\v:/ contained containedin=lyxHeader
syntax keyword lyxHeaderParamsKW Requires Excludes Category Author contained containedin=lyxHeader
" syntax cluster lyxHeaderParams contains=lyxHeaderParamOpers,lyxHeaderParamsKW 

syntax match 	lyxFormatError /\v[^[:space:][:digit:]]/ contained containedin=lyxFormatLine
syntax keyword 	lyxFormatKW format contained containedin=lyxFormatLine
syntax match 	lyxFormatNumber /\d\{1,2\}/ contained containedin=lyxFormatLine
syntax region 	lyxFormatLine 
	\ start=/\vformat/ end=/\v$/
	\ contains=lyxFormatKW,lyxFormatNumber,lyxFormatError keepend oneline

syntax region lyxPreamble 
	\ matchgroup=lyxPreambleKeywords
	\ start=/\%(AddTo\)\?Preamble/
	\ end=/EndPreamble/
	\ contains=@lyxTeX,lyxPreambleKeywords 

syntax region lyxHTMLPreamble
	\ matchgroup=lyxPreambleKeywords
	\ start=/\%(AddTo\)\?HTMLPreamble/
	\ end=/EndPreamble/
	\ contains=@lyxHTML,lyxPreambleKeywords

syntax region lyxString start=+"+ end=+"+ skip=+\\"+ oneline 



" CiteEngineType Syntax
syntax region lyxCiteEngineType start=/\v\cCiteEngineType/ end=/\v$/ keepend oneline 
	\ contains=lyxCiteEngineTypeDecl,lyxCiteEngineTypeKW

syntax keyword  lyxCiteEngineTypeKW  containedin=lyxCiteEngineType contained 
	\ CiteEngineType

syntax keyword lyxCiteEngineTypeDecl containedin=lyxCiteEngineType,lyxCiteEngine,lyxCiteFormat contained
	\ authoryear 
	\ numerical 
	\ default

" DefaultBiblio
syntax region lyxDefaultBiblio start=/\vDefaultBiblio/ end=/\v\w+/ keepend oneline contains=lyxDefaultBiblioKW
syntax keyword lyxDefaultBiblioKW contained containedin=lyxDefaultBiblio DefaultBiblio


" CiteEngine Syntax
syntax region   lyxCiteEngine start=/\v\cciteengine\s/ end=/\vend/ keepend contains=lyxCiteEngineStuff

syntax keyword  lyxCiteEngineTypeKW  containedin=lyxCiteEngineType,lyxCiteEngine contained
	\ CiteEngine
	\ End

" CiteFormat Syntax
syntax region 	lyxCiteFormat start=/\vciteformat/ end=/end/ contains=lyxCiteFormatContent,lyxCiteKeywords,lyxCiteEngineTypeDecl
syntax match 	lyxCiteError /\v\c[_a-z%!]+/ contained containedin=lyxCiteFormat,lyxCiteError
syntax match 	lyxCiteType "\v\c[a-z!\[\]\{\}]+"  contained containedin=lyxCiteFormat

syntax region 	lyxCiteExpansion start=+%+ end=+%+
	\ oneline keepend excludenl contained containedin=lyxCiteError,lyxCiteFormat contains=lyxCiteExpansionError,lyxCiteVariable
syntax match 	lyxCiteExpansionVariable /\v\c[_a-z]+/ contained containedin=lyxCiteExpansion

syntax match    lyxCiteTranslation "\v\c[_][a-z]+" contained containedin=lyxCiteFormat
syntax match 	lyxCiteXpErr1 	/\v\c[^!%_a-z]+/ contained containedin=lyxCiteExpansion
syntax cluster  lyxCiteExpansionError contains=lyxCiteXpErr1

syntax keyword 	lyxCiteKeywords contained containedin=lyxCiteFormat
	\ CiteFormat
	\ End


highlight default link lyxString String
highlight lyxComment term=bold ctermfg=cyan guifg=cyan

highlight link lyxHeader 		SpecialComment
highlight link lyxHeaderKeywords 	PreProc 
highlight link lyxHeaderDescriptionKW 	Keyword
highlight link lyxHeaderDescriptionLine String
highlight lyxHeaderParamLine 	ctermfg=white
highlight link lyxHeaderParamsKW        PreProc
highlight link lyxHeaderParamOpers      Operator

highlight link lyxFormatError 		Error
highlight link lyxFormatKW 		Keyword
highlight link lyxFormatNumber 		Number

highlight link lyxKeywords 		Keyword
highlight link lyxPreamble 		SpecialComment

highlight lyxFormatNumber 	term=bold ctermfg=Blue guifg=LightGreen
highlight lyxPreambleKeywords 	term=bold ctermfg=green guifg=green

highlight link lyxCiteEngineTypeKW 	PreProc
highlight lyxCiteEngineTypeDecl 	ctermfg=green

highlight link lyxDefaultBiblio 	Constant
highlight link lyxDefaultBiblioKW 	Keyword

highlight link lyxCiteError 		Error
highlight link lyxCiteType 		String
highlight lyxCiteTranslation 	ctermfg=red guifg=red
highlight lyxCiteKeywords 	term=bold ctermfg=green guifg=green
highlight lyxCiteExpansion 	ctermfg=red guifg=red

highlight link lyxCiteExpansionError 	Error
highlight lyxCiteExpansionVariable 	term=bold ctermfg=white guifg=white
highlight link lyxCiteOper		Operator


let b:current_syntax="lyx-layout"
