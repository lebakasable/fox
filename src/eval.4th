include stack.4th
include string.4th

s" +" 2constant inst-plus
s" -" 2constant inst-minus
s" *" 2constant inst-mult
s" /" 2constant inst-div
s" =" 2constant inst-equals
s" ." 2constant inst-dump

4096 stack constant fox-stack

variable curr-word

: eval-push ( n -- )
  fox-stack >stack ;

: eval-plus  fox-stack stack> fox-stack stack> + fox-stack >stack ;
: eval-minus fox-stack stack> fox-stack stack> - fox-stack >stack ;
: eval-mult  fox-stack stack> fox-stack stack> * fox-stack >stack ;
: eval-div   fox-stack stack> fox-stack stack> / fox-stack >stack ;

: eval-equals
  fox-stack stack> fox-stack stack> = if
    1 fox-stack >stack
  else
    0 fox-stack >stack
  then ;

: eval-dump
  fox-stack stack> . ;

: eval-tokens ( tokens -- )
  0 ?do
    dup 2@ inst-plus str= if
      eval-plus
    else
    dup 2@ inst-minus str= if
      eval-minus
    else
    dup 2@ inst-mult str= if
      eval-mult
    else
    dup 2@ inst-div str= if
      eval-div
    else
    dup 2@ inst-equals str= if
      eval-equals
    else
    dup 2@ inst-dump str= if
      eval-dump
    else
    dup 2@ s" " str= if
    else
      dup 2@ s>n eval-push
    then then then then then then then
    1 curr-word +! cell+ cell+
  loop ;
