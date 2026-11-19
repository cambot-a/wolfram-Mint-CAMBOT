{-
-- EPITECH PROJECT, 2026
-- CalcCell.hs
-- File description:
-- CalcCell
-}

module CalcCell (
    calcCell
) where

import Data.Maybe (fromMaybe)
import BinToInt

safeLookup :: [a] -> Int -> Maybe a
safeLookup [] _ = Nothing
safeLookup (x:_) 0 = Just x
safeLookup (_:xs) n
    | n < 0 = Nothing
    | otherwise = safeLookup xs (n - 1)

calcCell :: Bool-> [Bool] -> [Bool] -> Bool
calcCell x1 (x2:x3:_) rule = fromMaybe False
    (safeLookup rule ((length rule) - (binToInt [x1,x2,x3]) - 1))
calcCell x1 (x2:_) rule = fromMaybe False
    (safeLookup rule ((length rule) - (binToInt [x1,x2,False]) - 1))
calcCell x1 [] rule = fromMaybe False
    (safeLookup rule ((length rule) - (binToInt [x1,False,False]) - 1))
