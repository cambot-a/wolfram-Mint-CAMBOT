{-
-- EPITECH PROJECT, 2026
-- ShowGen.hs
-- File description:
-- ShowGen
-}

module ShowGen (
    showGens
) where

import WolframConfig
import GenStep

cellAsChar :: Bool -> Char
cellAsChar True = '*'
cellAsChar False = ' '

genAsStr' :: String -> WolframConfig -> [Bool] -> String
genAsStr' str (WolframConfig _ _ _ winWidth _) _ | winWidth <= 0 = reverse ('\n':str)
genAsStr' str config@(WolframConfig _ _ _ winWidth _) []
    = genAsStr' (' ':str) config{wlfWindow=(winWidth - 1), wlfMove=0} []
genAsStr' str config@(WolframConfig _ _ _ winWidth move) gen@(x:xs)
    | move < 0 = genAsStr' str config{wlfMove=(move + 1)} xs
    | move > 0 = genAsStr' (' ':str) config{wlfMove=(move - 1), wlfWindow=(winWidth - 1)} gen
    | otherwise = genAsStr' ((cellAsChar x):str) config{wlfWindow=(winWidth - 1)} xs

genAsStr :: WolframConfig -> [Bool] -> String
genAsStr = genAsStr' ""

showGens :: WolframConfig -> [Bool] -> [String]
showGens config@(WolframConfig _ _ 0 _ _) gen = (genAsStr config gen):[]
showGens config@(WolframConfig rule _ lineCnt _ move) gen =
    (genAsStr config gen)
    :(showGens config{wlfLines=(lineCnt - 1), wlfMove=(move - 1)} (genStep rule gen))
-- showGen config@(WolframConfig rule _ lineCnt winWidth move) gen
