" ycm
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_max_diagnostics_to_display = 0

" chromatica
let g:chromatica#responsive_mode=1

" Toggles numbers between hybrid and absolute based on the mode
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

" mappings for saving and closing vim
map <Leader>x :x<CR>
map <Leader>q :q<CR>

" disabling arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" source all the plugins
source ~/.vim_runtime/my_plugins.vim
