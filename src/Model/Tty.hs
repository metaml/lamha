module Model.Tty where

import Prelude
import Polysemy

data Tty m a where
  Get :: Tty m String
  Put :: String -> Tty m ()
  Put' :: Show a => a -> Tty m ()

makeSem ''Tty

runTtyIO :: Member (Embed IO) r => Sem (Tty ': r) a -> Sem r a
runTtyIO = interpret $ \case
  Get -> embed getLine
  Put msg -> embed $ putStrLn msg
  Put' a -> embed $ print a