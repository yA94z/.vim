let $DEIN_REPOS_DIR = expand('$HOME/.vim/dein/repos/github.com/Shougo/dein.vim')

set runtimepath^=$DEIN_REPOS_DIR

call dein#begin(expand('$HOME/.vim/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

if has('lua')
	call dein#add('Shougo/neocomplete.vim')
else
	call dein#add('Shougo/neocomplecache')
endif

call dein#add('Shougo/neosnippet-snippets')

call dein#add('Shougo/neosnippet.vim')

call dein#add('Shougo/vimfiler.vim')

call dein#add('vim-airline/vim-airline')

call dein#add('vim-airline/vim-airline-themes')

call dein#add('vim-jp/vimdoc-ja')

call dein#add('tpope/vim-endwise', {'on_ft' : 'ruby'})

call dein#add('zah/nim.vim')

call dein#add('scrooloose/nerdtree')

call dein#add('aklt/plantuml-syntax')

call dein#add('mattn/emmet-vim', {
            \   'on_ft' : [
            \   'html',
            \   'eruby',
            \   ],
            \ })

call dein#add('othree/html5.vim', {
            \   'on_ft' : [
            \   'html',
            \   'eruby',
            \   ],
            \ })

call dein#add('hail2u/vim-css3-syntax', {
            \   'on_ft' : [
            \   'css',
            \   'scss',
            \   ],
			\ })

call dein#add('slim-template/vim-slim', {
			\	'on_ft' : [
			\	'slim'
			\	],
			\ })

call dein#add('wakatime/vim-wakatime')

call dein#add('thinca/vim-quickrun')

call dein#end()
