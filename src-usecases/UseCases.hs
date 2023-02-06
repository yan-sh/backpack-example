{-# LANGUAGE OverloadedStrings #-}

module UseCases where

import Sig
import Data.Text
import Models

myCase :: Fx Text
myCase = do
  bump (MetricName "123")
  email <- selectUserEmailById 42
  pure $ case email of
    Nothing -> "Not found"
    Just (UserEmail x) -> x
