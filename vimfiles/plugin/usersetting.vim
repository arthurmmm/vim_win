colorscheme user
set guifont=Lucida\ Sans\ Typewriter:h11
setlocal noswapfile 
set bufhidden=hide
set shortmess=atI
set nobackup
set noshowcmd
set nu
set nocompatible
set expandtab
set smarttab
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

let g:winManagerWindowLayout = "FileExplorer"
let $LOG="C:\\SHARE_WITH_LAPTOP\\logs"

call HideHeader()


map <silent> <F2> :call HideHeader()<CR>
map <C-UP> :call ChangeFontSize(1)<CR>
map <C-DOWN> :call ChangeFontSize(-1)<CR>
map <C-f> :FILTER 
map <ESC> :nohl<CR>
map <F5>  :PY<CR>
imap <F5> <ESC>:PY<CR>
map @	*#
map T   :tabnew 
vmap m  \m

command			LOG		        :call LogBasic()
command			FIRMWARE	    :call Firmware()
command -nargs=1	FILTER		:call Filter(<f-args>)
command             WWN         :call SwapWWN()
command         PY              !python %
command         PORT            :call PortTranslate
command -nargs=1    PYLOAD      :call PyLoad(<f-args>)

au BufRead,BufNewFile *.log			LOG
au BufRead,BufNewFile firmware.log*		FIRMWARE
autocmd BufEnter * cd %:p:h

hi MarkWord1  guibg=#990033    guifg=White
hi MarkWord2  guibg=#996633    guifg=White
hi MarkWord3  guibg=#000099    guifg=White
hi MarkWord4  guibg=#003333    guifg=White
hi MarkWord5  guibg=#669900    guifg=White
hi MarkWord6  guibg=#663366    guifg=White

