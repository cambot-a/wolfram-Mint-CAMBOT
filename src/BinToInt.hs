{-
-- EPITECH PROJECT, 2026
-- BinToInt.hs
-- File description:
-- BinToInt
-}

module BinToInt (
    binToInt
) where

bitAsInt :: Bool -> Int
bitAsInt True = 1
bitAsInt False = 0

binToIntRec :: [Bool] -> Int -> Int
binToIntRec [] _ = 0
binToIntRec (bit:bytes) n = ((2 ^ n) * (bitAsInt bit))
    + (binToIntRec bytes (n + 1))

binToInt :: [Bool] -> Int
binToInt bin = binToIntRec (reverse bin) 0
