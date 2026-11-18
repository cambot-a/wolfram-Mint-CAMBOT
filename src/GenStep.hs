{-
-- EPITECH PROJECT, 2026
-- GenStep.hs
-- File description:
-- GenStep
-}

module GenStep (
    calcCellN
) where

import WolframConfig
import RuleInfo
import BinToInt

{-
./wolfram --rule N [--start val] [--lines val] [--window val] [--move val]

- `--rule val`  : the ruleset to use (mandatory)
- `--start val` : the generation number at which to start the display
                  (default = 0)
- `--lines val` : the number of lines to display. default -> program never
                  stops.
- `--window val`: the number of cells to display on each line (line width).
                  If even, the central cell is displayed in the next cell on
                  the right.
                  (default = 80)
- `--move val`  : a translation to apply on the window. If negative, the
                  window is translated to the left.
                  If positive, it’s translated to the right
-}
-- binToInt

calcCellN :: Bool -> [Bool] -> [Bool] -> Bool -- partial, only call with non-empty list
calcCellN x1 (x2:x3:_) rule = rule!!((length rule) - (binToInt [x1,x2,x3]) - 1)
calcCellN x1 [x2] rule = calcCellN x1 [x2,False] rule
calcCellN x1 [] rule = calcCellN x1 [False,False] rule

ruleStep' :: [Bool] -> [Bool] -> [Bool]
ruleStep' [] _ = []
ruleStep' (x:xs) rule = (calcCellN x xs rule):(ruleStep' xs rule)

ruleStep :: [Bool] -> [Bool] -> [Bool]
ruleStep [] _ = []
ruleStep gen rule = ruleStep' (False:gen) rule

genStep :: WolframConfig -> [Bool] -> [Bool]
genStep (WolframConfig rule _ _ _ _) generation = ruleStep generation (makeRuleInfo rule)
