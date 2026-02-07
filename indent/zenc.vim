if exists("b:did_indent")
    finish
endif

let b:did_indent = 1
let b:undo_indent = "setlocal cindent<"

setlocal cindent
