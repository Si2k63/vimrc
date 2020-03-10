" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'itchyny/lightline.vim'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'valloric/youcompleteme'

call vundle#end()            " required
filetype plugin indent on    " required

" Think this is for CtrlP
set path+=**
set wildmenu

" Relative Numbers
:set number relativenumber
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" Mappings (Old habits die hard)
silent! nmap <F3> :NERDTreeToggle<CR>

nnoremap <silent> <Tab> 1gt
nnoremap <S-Left> :tabprevious<CR>
nnoremap <S-Right> :tabnext<CR>

nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" Colorscheme
:colorscheme atom-dark-256

" CtrlP default new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<Tab>'],
    \ }

" lightline open in tab
set laststatus=2

" automatically load and save session on start/exit.
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . FindSessionDirectory()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . FindSessionDirectory()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

function FindSessionDirectory() abort
  if len(argv()) > 0
    return fnamemodify(argv()[0], ':p')
  endif
  return getcwd()
endfunction!

" Session restoring
autocmd vimenter * silent! lcd %:p:h
autocmd VimEnter * nested :call LoadSession()
autocmd VimLeave * :tabdo NERDTreeClose
autocmd VimLeave * :call MakeSession()

" Open as new tab, quit on open, delete buffers automatically, get rid of
" unwanted stuff from NERDTree
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 0
let NERDTreeDirArrows = 1

" Set indentation
set ts=4 sw=4
