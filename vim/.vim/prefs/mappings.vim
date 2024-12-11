" jk is escape  -.-
inoremap jk <esc>
inoremap <space><space> <esc>:w<cr>
test

" make tmux and vim play nicely together
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>

" remove mapping to be used in nerdtree
inoremap <Nul> <C-n>

" move vertically by visual line
" nnoremap j gj
" nnoremap k gk

" no shift for colon cmds
nnoremap ; :
vnoremap ; :

" tab navigation
nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>

" tab opening
nnoremap tt  :tabedit<Space>
nnoremap td  :tabclose<CR>

" Line swapping. I don't really use this that often
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

nnoremap <space><space> :w<CR>

" Create window splits easier
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" always use very magic mode when searching
nnoremap / /\v
vnoremap / /\v

nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
