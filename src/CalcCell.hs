{-
-- EPITECH PROJECT, 2026
-- CalcCell.hs
-- File description:
-- CalcCell
-}

module CalcCell (
    calcCell
) where

import BinToInt

calcCell :: Bool -> Bool -> [Bool] -> [Bool] -> Bool
calcCell x1 x2 (x3:_) rule = rule!!((length rule) - (binToInt [x1,x2,x3]) - 1)
calcCell x1 x2 [] rule = rule!!((length rule) - (binToInt [x1,x2,False]) - 1)
