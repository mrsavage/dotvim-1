" Check python support
if !has('python')
    echo "Error: PyLint required vim compiled with +python."
    finish
endif

" Check for pylint plugin is loaded
if exists("loaded_pylint")
    finish
endif
let loaded_pylint = 1

" Init variables
let g:PyLintDirectory = expand('<sfile>:p:h')
if !exists('g:PyLintDissabledMessages')
    let g:PyLintDissabledMessages = 'C0103,C0111,C0301,W0141,W0142,W0212,W0221,W0223,W0232,W0401,W0613,W0631,E1101,E1120,R0903,R0904,R0913'
endif
if !exists('g:PyLintGeneratedMembers')
    let g:PyLintGeneratedMembers = 'REQUEST,acl_users,aq_parent,objects,DoesNotExist,_meta,status_code,content,context'
endif
if !exists('g:PyLintCWindow')
    let g:PyLintCWindow = 1
endif
if !exists('g:PyLintSigns')
    let g:PyLintSigns = 1
endif
if !exists('g:PyLintOnWrite')
    let g:PyLintOnWrite = 1
endif

" Call PyLint only on write
if g:PyLintOnWrite
    augroup python
        au!
        au BufWritePost <buffer> call s:PyLint()
    augroup end
endif

" Commands
command PyLintToggle :let b:pylint_disabled = exists('b:pylint_disabled') ? b:pylint_disabled ? 0 : 1 : 1
command PyLint :call s:PyLint()

" Signs definition
sign define W text=WW texthl=Todo
sign define C text=CC texthl=Comment
sign define R text=RR texthl=Visual
sign define E text=EE texthl=Error

python << EOF

import sys, vim, StringIO

sys.path.insert(0, vim.eval("g:PyLintDirectory"))

from logilab.astng.builder import MANAGER
from pylint import lint, checkers

linter = lint.PyLinter()
checkers.initialize(linter)
linter.set_option('output-format', 'parseable')
linter.set_option('disable', vim.eval("g:PyLintDissabledMessages"))
linter.set_option('reports', 0)

def check():
    target = vim.eval("expand('%:p')")
    MANAGER.astng_cache.clear()
    linter.reporter.out = StringIO.StringIO()
    linter.check(target)
    vim.command('let pylint_output = "%s"' % linter.reporter.out.getvalue())

EOF

function! s:PyLint()

    if exists("b:pylint_disabled") && b:pylint_disabled == 1
        return
    endif

    if &modifiable && &modified
        write
    endif	

    py check()

    let b:qf_list = []
    for error in split(pylint_output, "\n")
        let b:parts = matchlist(error, '\v([A-Za-z\.]+):(\d+): \[([EWRCI]+)[^\]]*\] (.*)')

        if len(b:parts) > 3

            " Store the error for the quickfix window
            let l:qf_item = {}
            let l:qf_item.filename = expand('%')
            let l:qf_item.bufnr = bufnr(b:parts[1])
            let l:qf_item.lnum = b:parts[2]
            let l:qf_item.type = b:parts[3]
            let l:qf_item.text = b:parts[4]
            call add(b:qf_list, l:qf_item)

        endif

    endfor

    " Open cwindow
    if g:PyLintCWindow
        call setqflist(b:qf_list, 'r')
        if len(b:qf_list)
            cwindow
        else
            cclose
        endif
    endif

    " Place signs
    if g:PyLintSigns
        call s:PlacePyLintSigns()
    endif

endfunction

function! s:PlacePyLintSigns()
    "first remove all sings
    sign unplace *

    "now we place one sign for every quickfix line
    let l:id = 1
    for item in getqflist()
        execute(':sign place '.l:id.' name='.l:item.type.' line='.l:item.lnum.' buffer='.l:item.bufnr)
        let l:id = l:id + 1
    endfor
endfunction
