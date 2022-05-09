" DO NOT PLACE PLUGIN RELATED MAPPINGS HERE

" jk is escape  -.-
inoremap jk <esc>

" make tmux and vim play nicely together
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <C-H> <C-\><C-n><C-w>h
tnoremap <C-J> <C-\><C-n><C-w>j
tnoremap <C-K> <C-\><C-n><C-w>k
tnoremap <C-L> <C-\><C-n><C-w>l

" remove mapping to be used in nerdtree
inoremap <Nul> <C-n>

" Fox for Ack
cnoreabbrev Ack Ack!
cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" no shift for colon cmds
nnoremap ; :
vnoremap ; :

" tab navigation
nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>

" tab arrangement, Shift-H and Shift-L to move tabs
" nnoremap <silent> <lt> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
" nnoremap <silent> > :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
"
" tab opening
nnoremap tt  :tabedit<Space>
nnoremap td  :tabclose<CR>

" Shift-U and D for document navigation(page up, page down)
nnoremap <S-U> <C-U>
map <S-D> <nop>
nnoremap <S-D> <C-D>

" Line swapping. I don't really use this that often
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" Create window splits easier. The default
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nnoremap <C-t> <Cmd>CocCommand explorer<CR>

" always use very magic mode when searching
"nnoremap / /\v
"vnoremap / /\v
"
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

nmap <F1> :CocCommand java.debug.vimspector.start<CR>
