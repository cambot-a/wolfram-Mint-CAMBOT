module Main (main) where

import WolframConfig
import showWolfram

main :: IO ()
main = getArgs >>= WolframConfig defaultConf >>= showWolfram
