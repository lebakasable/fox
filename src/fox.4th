include string.4th
include eval.4th
include utils.4th

4096 constant max-line

variable file
variable line
variable curr-line

: fox
  1 arg r/o 
  try
    open-file dup throw 
  endtry-iferror
    ." ERROR: " .error ." ." cr
    1 (bye)
  then 
  swap file !
  begin 
    pad max-line file @ read-line rot dup line !
  while
    pad line @ pad place
    s"  " pad +place 
    pad count -trailing s"  " split 
    try
      eval-tokens
    endtry-iferror
      1 arg type ." :"
      curr-line @ 1 + n>s type ." :"
      curr-word @ n>s type ." : "
      .error ." ." cr
      1 (bye)
    then 
    1 curr-line +!
  repeat
  file @ close-file ;
