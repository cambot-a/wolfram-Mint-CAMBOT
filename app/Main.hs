module Main (main) where

import WolframConfig
import ShowWolfram
import System.Environment

main :: IO ()
main = getOpts <$> getArgs >>= showWolfram
