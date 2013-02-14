{-# LANGUAGE PackageImports #-}
module FayRef (FayRef, newFayRef, readFayRef, writeFayRef, modifyFayRef,
               modifyFayRef') where

import Prelude
import FFI

-- |A mutable variable in the 'Fay' monad.
data FayRef a = FayRef

-- |Build a new 'FayRef'.
newFayRef :: a -> Fay (FayRef a)
newFayRef = ffi "{contents: %1}"

-- |Write a new value into a 'FayRef'.
readFayRef :: FayRef a -> Fay a
readFayRef = ffi "%1['contents']"

-- |Write a new value into a 'FayRef'.
writeFayRef :: FayRef a -> a -> Fay ()
writeFayRef = ffi "%1['contents']=%2"

-- |Mutate the contents of a 'FayRef'.
--
-- Be warned that 'modifyFayRef' does not apply the function strictly.  This
-- means if the program calls 'modifyFayRef' many times, but seldomly uses the
-- value, thunks will pile up in memory resulting in a space leak.
modifyFayRef :: FayRef a -> (a -> a) -> Fay ()
modifyFayRef ref f = readFayRef ref >>= (writeFayRef ref . f)

-- |Strict version of 'modifyFayRef'
modifyFayRef' :: FayRef a -> (a -> a) -> Fay ()
modifyFayRef' ref f = do
    x <- readFayRef ref
    let x' = f x
    writeFayRef ref $! x'
