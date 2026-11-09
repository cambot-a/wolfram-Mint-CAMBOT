{-
-- EPITECH PROJECT, 2026
-- WolframBootstrap.hs
-- File description:
-- WolframBootstrap
-}

module WolframConfig (
  WolframConfig(wlfRule, wlfStart, wlfLines, wlfWindow, wlfMove),
  DefaultConfig(confRule, confStart, confLines, confWindow, confMove),
  defaultConf,
  getOpts,
  show
) where

import Text.Read ( readMaybe )

data DefaultConfig = DefaultConfig {
  confRule :: Maybe Int,
  confStart :: Int,
  confLines :: Maybe Int,
  confWindow :: Int,
  confMove :: Maybe Int
}

data WolframConfig = WolframConfig {
  wlfRule :: Int,
  wlfStart :: Int,
  wlfLines :: Int,
  wlfWindow :: Int,
  wlfMove :: Int
}

defaultConf :: DefaultConfig
defaultConf = DefaultConfig {
  confRule=Nothing,
  confStart=0,
  confLines=Nothing,
  confWindow=80,
  confMove=Nothing
  }

defaultToFinalConfig :: DefaultConfig -> Maybe WolframConfig
defaultToFinalConfig (DefaultConfig (Just r) s (Just l) w (Just m)) =
  Just (WolframConfig r s l w m)
defaultToFinalConfig _ = Nothing

getOptsRec :: DefaultConfig -> [String] -> Maybe WolframConfig
getOptsRec config [] = defaultToFinalConfig config
getOptsRec config ("--rule":arg:xs) = getOptsRec (config {confRule=readMaybe arg}) xs
getOptsRec config ("--start":arg:xs) = readMaybe arg >>= \argval -> getOptsRec (config{confStart=argval}) xs 
getOptsRec config ("--lines":arg:xs) = getOptsRec (config {confLines=readMaybe arg}) xs 
getOptsRec config ("--window":arg:xs) = readMaybe arg >>= \argval -> getOptsRec (config{confWindow=argval}) xs 
getOptsRec config ("--move":arg:xs) = getOptsRec (config {confMove=readMaybe arg}) xs
getOptsRec _ _ = Nothing

getOpts :: [String] -> Maybe WolframConfig
getOpts args = getOptsRec defaultConf args

instance Show WolframConfig where
  show (WolframConfig rule start nblines window move) =
    "WolframConfig:" <>
    "\nrule = " <> show rule <>
    "\nstart = " <> show start <>
    "\nlines = " <> show nblines <>
    "\nwindow = " <> show window <>
    "\nmove = " <> show move
