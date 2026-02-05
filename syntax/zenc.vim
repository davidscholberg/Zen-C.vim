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
    \ impl
    \ import
    \ in
    \ let
    \ loop
    \ match
    \ opaque
    \ plugin
    \ print
    \ println
    \ raw
    \ ref
    \ return
    \ struct
    \ test
    \ trait
    \ union
    \ unless
    \ use
    \ volatile
    \ while

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

" Currently, only built-in types will be highlighted.
" If we wanted to properly support highlighting of custom types in all
" contexts in which they occur, that would complicate this plugin quite a bit.
" That functionality is more within the purview of a proper parser like
" Treesitter.
syn keyword zencType
    \ bool
    \ byte
    \ c_char c_uchar
    \ c_short c_ushort
    \ c_int c_unit
    \ c_long c_ulong
    \ char
    \ double
    \ F32 F64
    \ f32 f64
    \ float
    \ I8 I16 I32 I64 I128
    \ i8 i16 i32 i64 i128
    \ int
    \ int8_t int16_t int32_t int64_t
    \ int_fast8_t int_fast16_t int_fast32_t int_fast64_t
    \ int_least8_t int_least16_t int_least32_t int_least64_t
    \ intmax_t
    \ intptr_t
    \ isize
    \ long
    \ max_align_t
    \ nullptr_t
    \ ptrdiff_t
    \ short
    \ signed
    \ size_t
    \ string
    \ U0
    \ U8 U16 U32 U64 U128
    \ u0
    \ u8 u16 u32 u64 u128
    \ uint
    \ uint8_t uint16_t uint32_t uint64_t
    \ uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
    \ uint_least8_t uint_least16_t uint_least32_t uint_least64_t
    \ uintmax_t
    \ uintptr_t
    \ usize
    \ unsigned
    \ void

syn keyword zencConstant
    \ true
    \ false

syn match zencOperator /\v(\=|\.|\+|-|\*|\/|\%|\=\=|!=|<|>|<=|>=|&|\||\^|!|\~|\[|\])/

syn match zencDelimiter /\v(;|:|\(|\)|,|\{|\}|->)/

syn region zencString oneline start=/"/ skip=/\\"/ end=/"/

syn region zencContainedString contained oneline start=/"/ skip=/\\"/ end=/"/

syn region zencAngleString contained oneline start=/</ end=/>/

" int and float literals (including scientific notation)
syn match zencNumber /\v-?(\d+|\d+\.?\d+)([Ee]-?\d+)?/

" hex literal
syn match zencNumber /\v0[Xx][0-9A-Fa-f]+/

" binary literal
syn match zencNumber /\v0[Bb][01]+/

" This match exists solely to prevent identifiers with numbers in them from
" being highlighted as numbers. This syntax group is intentionally not linked
" with Identifier in order to more closely match the syntax highlighting
" provided for other languages.
syn match zencIdentifier /\v[A-Za-z_]\w*/

syn match zencFunctionName /\v[A-Za-z_]\w*\ze\(/

syn match zencDecorator contains=zencDecoratorName /\v\@\w+/

syn match zencEllipsis /\v\.\.\./

syn region zencMacro contains=zencContainedString start=/\v^\s*#/ skip=/\\$/ end=/$/

" Special coloring for filename strings in include macros
syn match zencMacro contains=zencContainedString,zencAngleString /\v^\s*#\s*include\s+[<"].+[>"]/

" Special coloring for filename strings in include statments
syn match zencKeyword contains=zencContainedString,zencAngleString /\v^\s*include\s+[<"].+[>"]/

syn match zencComment /\v\/\/.*/

hi def link zencKeyword Statement
hi def link zencType Type
hi def link zencConstant Constant
hi def link zencOperator Operator
hi def link zencDelimiter Delimiter
hi def link zencString String
hi def link zencContainedString String
hi def link zencAngleString String
hi def link zencNumber Number
hi def link zencFunctionName Function
hi def link zencDecorator Statement
hi def link zencEllipsis Special
hi def link zencMacro Constant
hi def link zencInclude Statement
hi def link zencComment Comment

let b:current_syntax = "zenc"

let &cpo = s:save_cpo
unlet s:save_cpo
