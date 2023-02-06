module Main where

import qualified UseCasesProd
import qualified UseCasesTest
import qualified Prod
import qualified Test
import Data.Text
import Control.Monad.Trans.Reader

runProd :: Prod.Fx a -> IO a
runProd (Prod.Fx f) = runReaderT f () 

runTest :: Test.Fx a -> IO a
runTest (Test.Fx f) = f

main :: IO ()
main = do
  putStrLn "Run prod"
  r1 <- runProd UseCasesProd.myCase
  putStrLn (unpack r1)
  putStrLn "Run test"
  r2 <- runTest UseCasesTest.myCase
  putStrLn (unpack r2)
