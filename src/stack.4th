: stack ( size -- stack-id )
    1+ cells here swap allot
    0 over ! ;

: set-stack ( rec-n .. rec-1 n recstack-id -- )
    over 0< if -4 throw then
    2dup ! cell+ swap cells bounds
    ?do i ! cell +loop ;

: get-stack ( recstack-id -- rec-n .. rec-1 n )
    dup @ >r r@ cells + r@ begin
        ?dup
    while
            1- over @
            rot cell -
            rot
    repeat
    drop r> ;

: map-stack ( i*x xt stack-id -- j*y f )
    dup cell+ swap @ cells bounds ?do
        i @ swap dup >r execute
        ?dup if r> drop unloop exit then
    r> cell +loop
    drop 0 ;

: >stack ( x stack-id -- )
    2dup 2>r nip get-stack 2r> rot 1+ swap set-stack ;

: stack> ( stack-id -- x )
    dup >r get-stack 1- r> rot >r set-stack r> ;

: depth-stack ( stack-id -- n )
    @ ;

: pick-stack ( n stack-id -- n' )
    2dup depth-stack 0 swap within 0= if -9 throw then
    cell+ swap cells + @ ;

: >back ( x stack-id -- )
    dup >r get-stack 1+ r> set-stack ;

: back> ( stack-id -- x )
    dup >r get-stack 1- r> set-stack ;
