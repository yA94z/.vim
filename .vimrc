filetype off

set notitle

set showmatch

set matchtime=1

set vb t_vb= 

set novisualbell

set fdm=marker

set tabstop=4

set ruler

set autoindent

set shiftwidth=4

set matchpairs& matchpairs+=<:>

set foldmethod=marker

set confirm

set ignorecase

set smartcase

set wrapscan

set encoding=utf-8

set laststatus=2

syntax on

colorscheme molokai

set t_Co=256

set pumheight=10

set noswapfile

set clipboard+=autoselect

set backspace=2

inoremap {<Enter> {}<Left><CR><ESC><S-o>

inoremap [<Enter> []<Left><CR><ESC><S-o>

augroup QuickFixCmd
	autocmd!
	autocmd QuickFixCmdPost *grep* cwindow
augroup END
""""""""""""""""""""""""""""""
" Crypt settings
""""""""""""""""""""""""""""""
"{{{
if has('cryptv')
	if v:version > 704 || v:version == 704 && has('patch401')
		set cryptmethod=blowfish2
	elseif v:version >= 703
		set cryptmethod=blowfish
	else
		set cryptmethod=zip
	endif
endif
"}}}
""""""""""""""""""""""""""""""
" tab settings
""""""""""""""""""""""""""""""
"{{{
"tab configuration(Shougo)
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

"tab line
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

"prefix key
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

"tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc (tab create)
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx (tab exit)
map <silent> [Tag]x :tabclose<CR>
" tn (tab next)
map <silent> [Tag]n :tabnext<CR>
" tp (tab previous)
map <silent> [Tag]p :tabprevious<CR>

"}}}
""""""""""""""""""""""""""""""
" Dein
""""""""""""""""""""""""""""""
"{{{
if filereadable(expand('$HOME/.vim/dein.vim'))
	source ${HOME}/.vim/dein.vim
endif
"}}}
"""""""""""""""""""""""""""""""""
"Emmet-vim
"""""""""""""""""""""""""""""""""
"{{{
let g:user_emmet_leader_key='<C-y>'
"}}}
""""""""""""""""""""""""""""""
"NERDTree
"""""""""""""""""""""""""""""""""
"{{{
"Open NERDTree.
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

"autocmd VimEnter * execute 'NERDTree'

let g:NERDTreeIgnore = ['.[oa]$', '.(so)$', '.(tgz|gz|zip)$' ]
"}}}
""""""""""""""""""""""""""""""""""
""neocomplete
""""""""""""""""""""""""""""""""""
"{{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scala' : $HOME.'/.vim/dict/scala.dict',
    \ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
    \ 'c' : $HOME.'/.vim/dict/c.dict',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
endfunction
"Enable TAB.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"OmniFunc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"OmniFunc pattern
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'

"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif    

let g:neocomplete#force_omni_input_patterns.java = '\%(\h\w*\|)\)\.\w*'
"}}}
""""""""""""""""""""""""
"snippet
""""""""""""""""""""""""
"{{{
"プラグインのキー設定
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"}}}
""""""""""""""""""""""""""""""
"vim-racer
"""""""""""""""""""""""""""""""""
"{{{
set hidden
let g:racer_cmd = "$HOME/.cargo/bin/racer"
"}}}
""""""""""""""""""""""""""""""
"vim-airline
"""""""""""""""""""""""""""""""""
"{{{
let g:airline_theme='murmur'
"}}}

filetype plugin indent on
