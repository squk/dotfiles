" DO NOT PLACE PLUGIN RELATED MAPPINGS HERE

" jk is escape  -.-
inoremap jk <esc>

" make tmux and vim play nicely together
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>

" remove mapping to be used in nerdtree
inoremap <Nul> <C-n>

cnoremap %% <C-R>=fnameescape(expand("%:p:h")."/")<CR>

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

" Shift-U and D for document navigation(page up, page down)
nnoremap <S-U> <C-U>
map <S-D> <nop>
nnoremap <S-D> <C-D>

" Line swapping. I don't really use this that often
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" Create window splits easier
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" always use very magic mode when searching
nnoremap / /\v
vnoremap / /\v

nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

function! s:createHabitsMappings(keys, message) abort
    for key in a:keys
        call nvim_set_keymap('n', key, ':call BreakHabitsWindow(' . string(a:message). ')<CR>', {'silent': v:true, 'nowait': v:true, 'noremap': v:true})
    endfor
endfunction

function! BreakHabitsWindow(message) abort
    " Define the size of the floating window
    let width = 50
    let height = 10

    " Create the scratch buffer displayed in the floating window
    let buf = nvim_create_buf(v:false, v:true)

    " create the lines to draw a box
    let horizontal_border = '+' . repeat('-', width - 2) . '+'
    let empty_line = '|' . repeat(' ', width - 2) . '|'
    let lines = flatten([horizontal_border, map(range(height-2), 'empty_line'), horizontal_border])
    " set the box in the buffer
    call nvim_buf_set_lines(buf, 0, -1, v:false, lines)

    " Create the lines for the centered message and put them in the buffer
    let offset = 0
    for line in a:message
        let start_col = (width - len(line))/2
        let end_col = start_col + len(line)
        let current_row = height/2-len(a:message)/2 + offset
        let offset = offset + 1
        call nvim_buf_set_text(buf, current_row, start_col, current_row, end_col, [line])
    endfor

    " Set mappings in the buffer to close the window easily
    let closingKeys = ['<Esc>', '<CR>', '<Leader>']
    for closingKey in closingKeys
        call nvim_buf_set_keymap(buf, 'n', closingKey, ':close<CR>', {'silent': v:true, 'nowait': v:true, 'noremap': v:true})
    endfor

    " Create the floating window
    let ui = nvim_list_uis()[0]
    let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (ui.width/2) - (width/2),
                \ 'row': (ui.height/2) - (height/2),
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ }
    let win = nvim_open_win(buf, 1, opts)

    " Change highlighting
    " call nvim_win_set_option(win, 'winhl', 'Normal:ErrorFloat')

    highlight CustomFloatingWindow ctermbg=11 guibg=black ctermfg=10 guifg=red
    call nvim_win_set_option(win, 'winhl', 'Normal:CustomFloatingWindow')
endfunction

" let windowHabitsKeys = [",tm"]
" let windowHabitsMessage = ["USE < ,fw > INSTEAD", "BREAK BAD HABITS"]
" call s:createHabitsMappings(windowHabitsKeys, windowHabitsMessage)
