if exists("b:did_indent")
    finish
endif

let b:did_indent = 1
let b:undo_indent = "setlocal indentexpr< indentkeys< lisp<"

setlocal nolisp

" Same as default except we remove `:` so that typing a colon doesn't reindent
" the line.
setlocal indentkeys=0{,0},0),0],0#,!^F,o,O,e

setlocal indentexpr=GetZencIndent()

" Find the first line number of a multi-line escaped line (i.e. lines with
" trailing backslashes).
function s:FindFirstEscapedLine(lnum)
    let cur_lnum = a:lnum

    while cur_lnum > 0
        if getline(cur_lnum) !~ '\v.+\\$'
            return cur_lnum + 1
        endif
        let cur_lnum -= 1
    endwhile

    return 1
endfunction

" Return the first previous non-blank line that is not a macro or part of an
" escaped block.
function s:PrevNonBlankSmart(lnum)
    if a:lnum == 1
        return 1
    endif

    let cur_lnum = a:lnum

    while cur_lnum > 0
        if getline(cur_lnum - 1) =~ '\v.+\\$'
            let cur_lnum = prevnonblank(s:FindFirstEscapedLine(cur_lnum - 2) - 1)
        elseif getline(cur_lnum) =~ '\v^#.*'
            let cur_lnum = prevnonblank(cur_lnum - 1)
        else
            return cur_lnum
        endif

        if cur_lnum == 1
            return 1
        endif
    endwhile

    return cur_lnum
endfunction

" Tell if given line number is within a multiline comment.
function s:InMultilineComment(lnum)
    let cur_lnum = a:lnum

    while cur_lnum > 0
        let cur_line = getline(cur_lnum)

        if cur_line =~ '\v^\s+\*($|[^\/](.*\*\/)@!.*)'
            let cur_lnum -= 1
            continue
        endif

        if cur_line =~ '\v^\s*\/\*(.*\*\/)@!.*'
            return v:true
        endif

        return v:false
    endwhile

    return v:false
endfunction

" Normalizes the indentation of a line down to the nearest multiple of
" shiftwidth().
function s:IndentSmart(lnum)
    let cur_indent = indent(a:lnum)
    return cur_indent - (cur_indent % shiftwidth())
endfunction

" Simple indent function that handles nesting of {} [] and () pairs,
" multi-line comments, macros, and lines with escaped newlines.
function GetZencIndent()
    let cur_line = getline(v:lnum)

    if cur_line =~ '\v^\s*#.*'
        " preprocessor macro
        return 0
    endif

    let prev_lnum = prevnonblank(v:lnum - 1)
    if prev_lnum == 0
        return 0
    endif

    let prev_indent = s:IndentSmart(prev_lnum)

    if s:InMultilineComment(prev_lnum)
        "continuation of multiline comment
        return prev_indent + 1
    endif

    let prev_line = getline(prev_lnum)

    if prev_line =~ '\v.+\\$'
        "continuation of escaped newline
        if s:FindFirstEscapedLine(prev_lnum - 1) == prev_lnum
            return prev_indent + shiftwidth()
        endif
        return prev_indent
    endif

    " skip over macro lines and escaped blocks
    let prev_smart_lnum = s:PrevNonBlankSmart(prev_lnum)
    if prev_smart_lnum == 0
        return 0
    endif

    let prev_smart_indent = s:IndentSmart(prev_smart_lnum)
    let prev_smart_line = getline(prev_smart_lnum)

    " we have a negative lookbehind here to makes sure the previous line is
    " not single-line commented
    if prev_smart_line =~ '\v^.*(\/\/.*)@<![{([]\s*(\/\/.*|\/\*.*\*\/\s*)?$'
        if cur_line =~ '\v^\s*[})\]].*'
            " current line closes new block
            return prev_smart_indent
        endif
        " increase indent for new block
        return prev_smart_indent + shiftwidth()
    endif

    if cur_line =~ '\v^\s*[})\]].*'
        " decrease indent for closed block
        return prev_smart_indent - shiftwidth()
    endif

    " chill with the previous indent level
    return prev_smart_indent
endfunction
