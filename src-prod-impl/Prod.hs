{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}

module Prod where

import Models
import Control.Monad.Trans.Reader

newtype Fx a = Fx {unFx :: ReaderT () IO a}
  deriving (Functor, Applicative, Monad)

selectUserEmailById :: Int -> Fx (Maybe UserEmail)
selectUserEmailById _ = pure (Just (UserEmail "prod@mail.com"))

bump :: MetricName -> Fx ()
bump _ = pure ()
