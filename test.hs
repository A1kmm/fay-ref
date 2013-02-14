import FayRef
import FFI
import Prelude

main = do
  fr <- newFayRef (10 :: Int)
  assertFay (readFayRef fr) (==10) "Read after create gives correct value"
  writeFayRef fr 20
  assertFay (readFayRef fr) (==20) "Write and read gives correct value"
  modifyFayRef fr (*2)
  assertFay (readFayRef fr) (==40) "modifyFayRef and read gives correct value"
  modifyFayRef' fr (*2)
  assertFay (readFayRef fr) (==80) "modifyFayRef' and read gives correct value"

consoleLog :: String -> Fay ()
consoleLog = ffi "console.log(%1)"

assertFay fx t msg = do
  r <- fx
  consoleLog $ (if t r then "Success" else "Failure") ++ " on test: " ++ msg
