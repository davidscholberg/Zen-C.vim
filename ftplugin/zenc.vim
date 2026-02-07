if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1
let b:undo_ftplugin = "setlocal fo< comments< commentstring<"

" Insert comment leader string when formatting/adding comment lines.
setlocal fo+=cro/q

" Set comment leader strings for formatting
setlocal comments=s1:/*,mb:*,ex:*/,://,:///

" Set comment leader string for gc command
setlocal commentstring=//\ %s
