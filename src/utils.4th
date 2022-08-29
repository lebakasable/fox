: to-stderr
  outfile-id
    stderr to outfile-id ;

: end-stderr
  to outfile-id ;
  
: clear-stack
  depth 0 do drop loop ;
