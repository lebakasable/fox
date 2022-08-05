: split ( str delim -- tokens )
    here >r 2swap
    begin
        2dup 2,
        2over search
    while
            dup negate here 2 cells - +!
            2over nip /string
    repeat
    2drop 2drop
    r> here over -
    dup negate allot
    2 cells / ;

: match-head ( a u a-key u-key -- a-right u-right true | a u false )
    2 pick over u< if 2drop false exit then
    dup >r
    3 pick r@ compare if rdrop false exit then
    swap r@ + swap r> - true ;

: i-dlit ( a u -- x x true | a u false )
    2dup s" -"  match-head >r
    dup 0= if nip rdrop exit then
    0 0 2swap >number nip if rdrop 2drop false exit then
    r> if dnegate then 2swap 2drop true ;

: i-lit ( a u -- x true | a u false )
    i-dlit if d>s true exit then false ;

: s>n ( a u -- x )
    i-lit if exit then
    pad place
    s" : unexpected token" pad +place
    pad count exception throw ;

: n>s ( n -- addr c )
    s>d <# #s #> ;