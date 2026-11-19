{-
-- EPITECH PROJECT, 2026
-- showWolfram
-- File description:
-- showWolfram
-}

module ShowWolfram (
  showWolfram
) where

import System.Exit (ExitCode (ExitFailure), exitWith)
import System.IO (hPutStrLn, stderr)
import WolframConfig
import GenerateFirstGen
import SkipGen
import ShowGen

usage :: String
usage = "USAGE: ./wolfram --rule N [--start val] [--lines val]"
    ++ " [--window val] [--move val]"

showUsage :: IO ()
showUsage = hPutStrLn stderr usage >> exitWith (ExitFailure 84)

makeGens :: WolframConfig -> [String]
makeGens (WolframConfig _ _ 0 _ _) = []
makeGens config@(WolframConfig rule start lineCnt _ move) =
    showGens config{wlfLines=(lineCnt - 1), wlfMove=(move - start)}
        (skipGen start rule (generateFirstGen config))

showWolfram :: Maybe WolframConfig -> IO ()
showWolfram Nothing = showUsage
showWolfram (Just config) = putStr (concat (makeGens config))
