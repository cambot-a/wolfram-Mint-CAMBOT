{-
-- EPITECH PROJECT, 2026
-- RuleInfo.hs
-- File description:
-- RuleInfo
-}

module RuleInfo (
    makeRuleInfo
) where
    
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

makeRuleInfo :: Int -> [Bool]
makeRuleInfo 30 = [False, False, False, True, True, True, True, False]
makeRuleInfo 90 = [False, True, False, True, True, False, True, False]
makeRuleInfo 110 = [False, True, True, False, True, True, True, False]
makeRuleInfo 16 = [False, False, False, True, False, False, False, False]
makeRuleInfo 222 = [True, True, False, True, True, True, True, False]
makeRuleInfo _ = [True, True, True, True, True, True, True, True]
