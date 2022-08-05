include stack.4th
include string.4th

s" +" 2constant inst-plus
s" -" 2constant inst-minus
s" *" 2constant inst-mult
s" /" 2constant inst-div
s" ." 2constant inst-dump

1024 stack constant fox-stack

: parse-push ( n -- )
    fox-stack >stack ;

: parse-plus  fox-stack stack> fox-stack stack> + fox-stack >stack ;
: parse-minus fox-stack stack> fox-stack stack> - fox-stack >stack ;
: parse-mult  fox-stack stack> fox-stack stack> * fox-stack >stack ;
: parse-div   fox-stack stack> fox-stack stack> / fox-stack >stack ;

: parse-dump
    fox-stack stack> . ;

: parse ( tokens -- )
    0 ?do
        dup 2@ inst-plus str= if
            parse-plus
        else
        dup 2@ inst-minus str= if
            parse-minus
        else
        dup 2@ inst-mult str= if
            parse-mult
        else
        dup 2@ inst-div str= if
            parse-div
        else
        dup 2@ inst-dump str= if
            parse-dump
        else
            dup 2@ s>n parse-push
        then then then then then
        cell+ cell+
    loop drop ;
