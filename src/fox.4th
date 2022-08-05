include string.4th
include parser.4th

4096 constant max-line

: third ( a b c -- a b c a )
    >r over r> swap ;

: read-lines ( file-id -- )
    begin pad max-line third read-line throw
    while pad swap 2drop
    repeat 2drop ;

: usage
    ." Usage: fox <input.fox> [flags]" cr
    ." Flags:" cr
    ."   --help      Print this help message." cr ;

create buf max-line allot
variable file
variable line
variable curr-line

: fox
    argc @ 1 = if
        outfile-id
        stderr to outfile-id
        usage
        ." ERROR: Not enough arguments" cr
        to outfile-id
        1 (bye)
    then
    
    1 arg s" --help" str= if
        usage
        bye
    else
        try
            1 arg r/o open-file swap file !
            begin buf max-line file @ read-line rot dup line !
            while
                    buf line @ pad place
                    s"  " pad +place pad count -trailing s"  " split parse
                    1 curr-line +!
            repeat
            file @ close-file
        endtry-iferror
            1 arg type ." :"
            curr-line @ 1 + n>s type ." :"
            curr-word @ 1 + n>s type ." : "
            .error cr 1 (bye)
        then 2drop 2drop drop
        cr bye
    then ;
