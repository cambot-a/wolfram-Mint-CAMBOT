{-
-- EPITECH PROJECT, 2026
-- GenerateFirstGen.hs
-- File description:
-- GenerateFirstGen
-}

module GenerateFirstGen (
    generateFirstGen
) where

import WolframConfig

generateBoolGeneration :: Int -> Int -> [Bool]
generateBoolGeneration 0 _ = []
generateBoolGeneration n 0 = True:(generateBoolGeneration (n - 1) (-1))
generateBoolGeneration n middle =
    False:(generateBoolGeneration (n - 1) (middle - 1))

generateFirstGen :: WolframConfig -> [Bool]
generateFirstGen (WolframConfig{wlfWindow = winWidth}) =
    generateBoolGeneration winWidth (div winWidth 2)
