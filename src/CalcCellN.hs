{-
-- EPITECH PROJECT, 2026
-- CalcCellN.hs
-- File description:
-- CalcCellN
-}

module CalcCellN (
    calcCellN
) where

import BinToInt

calcCellN :: Bool -> [Bool] -> [Bool] -> Bool
calcCellN x1 (x2:x3:_) rule = rule!!((length rule) - (binToInt [x1,x2,x3]) - 1)
calcCellN x1 [x2] rule = calcCellN x1 [x2,False] rule
calcCellN x1 [] rule = calcCellN x1 [False,False] rule
