" Vim syntax file
" Language:	log file	
" Maintainer:	Arthur (arthurcqy@gmail.com)
" Last Change:	2013/09/13 ÷‹ŒÂ 

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case ignore

" strings
syn match	_Title	".*:\s*$"
syn match	_S2	".*warning" ".*attention.*"
syn match 	_S1	"\S*error\S*" "\S*failure\S*" "\S*degrade\S*" "\S*degraded\S*" "\S*failed\S*"
syn match	_Tm	"^[0-9]\{4}-[0-9]\{2}-[0-9]\{2}\s.*"

" The default highlighting.
hi _S2		guifg=yellow
hi _S1		guibg=red guifg=white
hi _Title	guifg=green
hi _Tm		guifg=lightblue
