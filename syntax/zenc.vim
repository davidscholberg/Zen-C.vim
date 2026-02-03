if exists("b:current_syntax")
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

syn keyword zencKeyword
    \ alias
    \ as
    \ asm
    \ async
    \ autofree
    \ await
    \ break
    \ comptime
    \ const
    \ continue
    \ def
    \ defer
    \ else
    \ embed
    \ enum
    \ eprint
    \ eprintln
    \ extern
    \ fn
    \ for
    \ guard
    \ if
    \ import
    \ in
    \ let
    \ loop
    \ match
    \ opaque
    \ plugin
    \ print
    \ println
    \ ref
    \ return
    \ test
    \ union
    \ unless
    \ use
    \ volatile
    \ while

syn keyword zencContainedKeyword contained
    \ for
    \ impl
    \ struct
    \ trait

syn keyword zencDecoratorName contained transparent
    \ align
    \ cold
    \ comptime
    \ constructor
    \ ctype
    \ deprecated
    \ derive
    \ destructor
    \ device
    \ export
    \ global
    \ host
    \ hot
    \ inline
    \ must_use
    \ noinline
    \ noreturn
    \ packed
    \ pure
    \ section
    \ unused
    \ weak

" Currently commented out in favor of coloring contexts in which types occur.
" The advantage of the above approach is catching custom types, but the
" disadvantage is that capturing the context required to do this is a pain
" with regex-based matching.
"syn keyword zencType
"    \ bool
"    \ byte
"    \ char
"    \ double
"    \ f32 f64
"    \ float
"    \ i8 i16 i32 i64 i128
"    \ int
"    \ int8_t int16_t int32_t int64_t
"    \ int_fast8_t int_fast16_t int_fast32_t int_fast64_t
"    \ int_least8_t int_least16_t int_least32_t int_least64_t
"    \ intmax_t
"    \ intptr_t
"    \ isize
"    \ long
"    \ max_align_t
"    \ nullptr_t
"    \ ptrdiff_t
"    \ short
"    \ signed
"    \ size_t
"    \ string
"    \ u0
"    \ u8 u16 u32 u64 u128
"    \ uint
"    \ uint8_t uint16_t uint32_t uint64_t
"    \ uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
"    \ uint_least8_t uint_least16_t uint_least32_t uint_least64_t
"    \ uintmax_t
"    \ uintptr_t
"    \ usize
"    \ unsigned
"    \ void

syn keyword zencConstant
    \ true
    \ false

syn match zencOperator /\v(\=|\.|\+|-|\*|\/|\%|\=\=|!=|<|>|<=|>=|&|\||\^|!|\~|\[|\])/

syn match zencContainedOperator /=/

syn match zencDelimiter /\v(;|\(|\)|,|\{|\}|->)/

syn match zencContainedDelimiter /\v(\(|,)/

syn match zencColon contained /:/

syn region zencString oneline start=/"/ skip=/\\"/ end=/"/

syn match zencNumber /\v-?(\d+|\d*\.?\d+)/

syn match zencIdentifier /\v[A-Za-z_]\w*/

" Match type name or trait name in declaration.
syn match zencType contains=zencContainedKeyword /\v(struct|trait)\s+[A-Za-z_](\w|[<>])*/

" Match type and trait names in impl declaration.
syn match zencType contains=zencContainedKeyword /\vimpl\s+[A-Za-z_](\w|[<>])*(\s+for\s+[A-Za-z_](\w|[<>])*)?/

" Match type name in struct initializer (works in assignment and arg passing
" contexts).
syn match zencType contains=zencContainedDelimiter,zencContainedOperator /\v([^\=!<>]\=|\(|,)\s*[A-Za-z_](\w|[<>])*\ze\s*\{/

" Match type in struct field type specifier
syn match zencType contains=zencColon /\v:\s*([A-Za-z_](\w|[<>])*(\s+[A-Za-z_](\w|[<>])*)?|fn\**\(.*\))\ze\s*;/

" Match type in let binding
syn match zencType contains=zencColon /\v:\s*([A-Za-z_](\w|[<>])*(\s+[A-Za-z_](\w|[<>])*)?|fn\**\(.*\))\ze\s*\=/

syn match zencFunctionName /\v[A-Za-z_]\w*\ze\(/

syn match zencEllipsis /\v\.\.\./

syn match zencComment /\v\/\/.*/

syn match zencDecorator contains=zencDecoratorName /\v\@\w+/

hi def link zencComment Comment
hi def link zencKeyword Statement
hi def link zencContainedKeyword Statement
hi def link zencDecorator Statement
hi def link zencType Type
hi def link zencConstant Constant
hi def link zencString String
hi def link zencIdentifier Identifier
hi def link zencFunctionName Function
hi def link zencNumber Number
hi def link zencOperator Operator
hi def link zencContainedOperator Operator
hi def link zencDelimiter Delimiter
hi def link zencContainedDelimiter Delimiter
hi def link zencColon Delimiter
hi def link zencEllipsis Special

let b:current_syntax = "zenc"

let &cpo = s:save_cpo
unlet s:save_cpo
