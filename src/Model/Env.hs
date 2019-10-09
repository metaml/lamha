module Model.Env where

import Polysemy
import System.Environment

type Key = String
type Val = String

data Env m a where
  Get :: Key -> Env m (Maybe Val)
  Set :: Key -> Val -> Env m ()

makeSem ''Env

envToIO :: Member (Embed IO) r => Sem (Env ': r) a -> Sem r a
envToIO = interpret $ \case
  Get k -> embed $ lookupEnv k
  Set k v -> embed $ setEnv k v
