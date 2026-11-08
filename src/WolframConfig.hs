{-
-- EPITECH PROJECT, 2026
-- WolframBootstrap.hs
-- File description:
-- WolframBootstrap
-}

module WolframConfig (
  WolframConfig(confRule, confStart, confLines, confWindow, confMove),
  defaultConf,
  getOpts,
  show
) where

import Text.Read ( readMaybe )

data WolframConfig = WolframConfig {
  confRule :: Maybe Int,
  confStart :: Int,
  confLines :: Maybe Int,
  confWindow :: Int,
  confMove :: Maybe Int
}
defaultConf :: WolframConfig
defaultConf = WolframConfig {
  confRule=Nothing,
  confStart=0,
  confLines=Nothing,
  confWindow=80,
  confMove=Nothing
  }

getOpts :: WolframConfig -> [String] -> Maybe WolframConfig
getOpts config@(WolframConfig (Just _) _ (Just _) _ (Just _)) [] = Just config
getOpts _ [] = Nothing
getOpts config ("--rule":arg:xs) = getOpts (config {confRule=readMaybe arg}) xs
getOpts config ("--start":arg:xs) = readMaybe arg >>= \argval -> getOpts (config{confStart=argval}) xs 
getOpts config ("--lines":arg:xs) = getOpts (config {confLines=readMaybe arg}) xs 
getOpts config ("--window":arg:xs) = readMaybe arg >>= \argval -> getOpts (config{confWindow=argval}) xs 
getOpts config ("--move":arg:xs) = getOpts (config {confMove=readMaybe arg}) xs
getOpts _ _ = Nothing

instance Show WolframConfig where
  show (WolframConfig rule start nblines window move) =
    "WolframConfig:" <>
    "\nrule = " <> show rule <>
    "\nstart = " <> show start <>
    "\nlines = " <> show nblines <>
    "\nwindow = " <> show window <>
    "\nmove = " <> show move
