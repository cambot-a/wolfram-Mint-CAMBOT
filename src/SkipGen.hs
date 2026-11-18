{-
-- EPITECH PROJECT, 2026
-- SkipGen.hs
-- File description:
-- SkipGen
-}

module SkipGen (
    skipGen
) where

import GenStep

skipGen :: Int -> Int -> [Bool] -> [Bool]
skipGen 0 _ gen = gen
skipGen _ _ [] = []
skipGen n rule gen = skipGen (n - 1) rule (genStep rule gen)
