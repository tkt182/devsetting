set nocompatible

"---------------
"Tab Width
"---------------
set tabstop=4
set shiftwidth=4 " 自動インデントの幅
set expandtab
"----------------
"Color
"----------------
syntax enable
syntax on
set background=dark
hi Comment ctermfg=1
set guioptions-=m

" show line number
set number

set list " 不可視文字を表示
" set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% " タブを>--- 半角スペースを.で表示する
set listchars=tab:>-,trail:-,extends:»,precedes:«,nbsp:% " タブを>--- 半角スペースを.で表示する

" 検索結果のハイライト
set hlsearch

"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 追加プラグイン"
NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'scrooloose/syntastic'
NeoBundle 'b4b4r07/vim-autocdls'
" TypeScript"
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
"NeoBundle 'https://github.com/clausreinke/typescript-tools.git'
NeoBundle 'vim-perl/vim-perl'

NeoBundle 'fatih/vim-go'

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------


"---------------------------
" neocomplcache
"---------------------------

let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
	\ }

inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
