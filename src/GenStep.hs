{-
-- EPITECH PROJECT, 2026
-- GenStep.hs
-- File description:
-- GenStep
-}

module GenStep (
    genStep
) where

import WolframConfig
import RuleInfo
import CalcCell

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

ruleStep' :: [Bool] -> [Bool] -> [Bool]
ruleStep' [] _ = []
ruleStep' (x:xs) rule = (calcCell x xs rule):(ruleStep' xs rule)

ruleStep :: [Bool] -> [Bool] -> [Bool]
ruleStep [] _ = []
ruleStep gen rule = ruleStep' (False:False:gen) rule

genStep :: Int -> [Bool] -> [Bool]
genStep rule generation = ruleStep generation (makeRuleInfo rule)
