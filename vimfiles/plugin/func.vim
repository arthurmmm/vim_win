function! HideHeader()
	if &guioptions =~# 'T' 
        	set guioptions-=T
        	set guioptions-=m
    	else
        	set guioptions+=T
        	set guioptions+=m
    	endif
endfunction

function! ChangeFontSize(delta)
	let pattern=":h[0-9]*"
	let fontName = substitute(&guifont, pattern, "", "") . ":h"
	let fontSize = substitute(&guifont, fontName, "", '')
	let fontSize = fontSize + a:delta
	let &guifont = fontName . fontSize
endfunction	

function! LogBasic()
	syn case ignore
	syn match	_Title	".*:\s*$"
	syn match	_Tm	"^[0-9]\{4}-[0-9]\{2}-[0-9]\{2}\s.*"

	hi _Title	guifg=green
	hi _Tm		guifg=lightblue
endfunction

function! Firmware()
	syn match	_Alert	"\s[a-zA-Z]*\/[0-9]*\s"
	syn match	_WWN	"0x[0-9a-f]\{16}"
	syn match	_Port	"[AB][0-5]-FC0[0-3]"
	syn match	_Reporter "^[0-9]\{1,3}.[0-9]\{1,3}.[0-9]\{1,3}.[0-9]\{1,3}"
	syn match	_Time	"[0-9]\{4}\/[0-9]\{2}\/[0-9]\{2}\s[0-9]\{2}:[0-9]\{2}:[0-9]\{2}\.[0-9]\{2}"

	hi _Alert	guifg=lightred
	hi _WWN		guifg=#FFE3C8
	hi _Port	guifg=lightgreen
	hi _Reporter	guifg=lightcyan
	hi _Time	guifg=lightyellow

	badd $VIM/firmDict.txt

	map <buffer> <CR> :call GetDetail(getline("."))<CR>
endfunction
function! GetDetail(line)
	let alert = matchstr(a:line, "[a-zA-Z]\\+\\/[0-9]\\+\\s.*$")
	let alertTags = matchstr(alert, "[a-zA-Z]\\+\\/[0-9]\\+")
	let alertName = matchstr(alertTags, "[a-zA-Z]\\+")
	let alertNum = matchstr(alertTags, "[0-9]\\+")
	let alertMsg = substitute(alert, alertTags." ", "", "")

	buffer firmDict.txt		
	norm gg
	let query = "\t".alertName."\t".alertNum."\t"
	let qLine = split(getline(search(query)), "\t")
	if len(qLine) == 0
		echo "Not Found"
        buffer #
		return
	endif
	buffer #
	let @a = 		"id:\t\t\t"		.qLine[0]."\n".
				\"name:\t\t\t"		.qLine[1]."\n".
				\"component:\t\t"	.qLine[2]."\n".
				\"eventCode:\t\t"	.qLine[3]."\n".
				\"severity:\t\t"	.qLine[4]."\n".
				\"locale:\t\t\t"	.qLine[5]."\n".
				\"internalRCA:\t\t"	.qLine[6]."\n".
				\"customerRCA:\t\t"	.qLine[7]."\n".
				\"internalRemedy:\t"	.qLine[8]."\n".
				\"customerRemedy:\t"	.qLine[9]."\n".
				\"obsoleteEvent:\t\t"	.qLine[10]."\n".
				\"resendTimeout:\t\t"	.qLine[11]."\n".
				\"defaultEvent:\t\t"	.qLine[12]."\n".
				\"thresholdCount:\t\t"	.qLine[13]."\n".
				\"thresholdInterval:\t"	.qLine[14]."\n".
				\"arguments:\t\t"	.qLine[15]."\n".
				\"customerDescription:\t".qLine[16]."\n".
				\"internalDescription:\t".qLine[17]."\n".
				\"formatString:\t\t"	.qLine[18]."\n"
	wincmd n
	map <buffer> <ESC> :q!<CR>
	setlocal buftype=nofile
	setlocal noswapfile
	setlocal nonu
	norm "aP
	syntax match	_Title	 "^.*:\t"
	syntax match	_Err	"\tERROR$"
	syntax match	_Warn	"\tWARNING$"
	syntax match	_Info	"\tINFO$"

	hi _Title	guifg=lightblue
	hi _Err		guifg=lightred
	hi _Warn	guifg=#FFCC99
	hi _Info	guifg=green
endfunction

function! PyLoad(pyscript)
    if (bufname("%") == "")
        exe "w! C:\\SHARE_WITH_LAPTOP\\Vim\\python\\tempin.txt"
    endif
    exe "!python C:\\SHARE_WITH_LAPTOP\\Vim\\python\\" .a:pyscript .".py %" 
endfunction

function! SwapWWN()
    let wwn0 = search("\\w\\{2}\\(:\\w\\{2}\\)\\{7}")
    let wwn1 = search("\\w\\{16}")
    if wwn0 > wwn1 && wwn0 != 0
        let flag = 0
    elseif wwn1 > wwn0 && wwn1 != 0
        let flag = 1
    else
        let flag = -1
    endif
    if flag == 0
        exe "%s/://g"
        exe "%s/\\(\\w\\{16}\\)/0x\\1/g"
    elseif flag == 1
        if search("0x") != 0
            exe "%s/0x//g"
        endif
        exe "%s/\\(\\w\\{2}\\)/\\1:/g"
        exe "%s/:$//g"
    endif
endfunction

" Grep current file
function! Filter(pat)
	call FilteringNew().addToParameter('alt', a:pat).run()
	syn match	_LineNum	"^\s*\d*:"
	hi _LineNum	guifg=yellow

	" save current cursor position
"	let cur = line(".")
"	" move to line 1
"	1
"	" search from line 1
"	let res = search(a:pat, "cW")
"	if res == 0
"		echo "Not Found"
"		return
"	end
"	" save in reg
"	let @a = ""
"	while res != 0
"		let @a = @a.res.":  ".getline(res)."\n" 
"		let res = search(a:pat, "W")
"	endwhile
"	exe cur
"
"	" config grep window
"	new [result]
"	norm "aP
"	$d	
"	norm gg
"	setlocal nonu
"	setlocal buftype=nofile
"	setlocal noswapfile
"	resize 5
"
"	map <buffer> <ESC> :q!<CR>
"	map <buffer> <CR>  :let @a = matchstr(getline("."), "[0-9]*") \| 9999winc w \| exe @a<CR> 
"	syn match	_LineNum	"^\d*:"
"	hi _LineNum	guifg=yellow
endfunction

