Fay Ref
=======

This package works like Data.IORef, but in the Fay monad. It allows you to
create mutable variables and update them from within Fay.

```haskell
main :: Fay ()
main = do
  fr <- newFayRef (10 :: Int)
  readFayRef fr -- Should give 10.
  writeFayRef fr 20
  readFayRef fr -- Should give 20.
  modifyFayRef fr (*2)
  readFayRef fr -- Should give 40.
  -- The above was non-strict; here is the strict variant.
  modifyFayRef' fr (*2)
  readFayRef fr -- Should give 80.
  return ()
```

Usage
-----

To use this with fay, cabal install the package which will put the
source files in fay ~/.cabal/share/fay-ref-0.1.0.0/src. You can then
compile with fay using

```bash
fay --package fay-ref MyFile.hs
```
