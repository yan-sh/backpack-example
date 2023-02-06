{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}

module Test where

import Models

newtype Fx a = Fx {unFx :: IO a}
  deriving (Functor, Applicative, Monad)

selectUserEmailById :: Int -> Fx (Maybe UserEmail)
selectUserEmailById _ = pure (Just (UserEmail "test@mail.com"))

bump :: MetricName -> Fx ()
bump _ = pure ()
