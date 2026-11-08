# wolfram

Wolfram's elementary cellular automaton in the terminal, written in Haskell.

## Description

Running `make` builds `wolfram`

**`wolfram --rule N [--start val] [--lines val] [--window val] [--move val]`**
displays Wolfram's elementary cellular automaton for rule `N` in the terminal,
one generation per line.

### Behaviour

1. The program reads its options (see [Running](#running)). With no option or
   an invalid option, it displays a usage message, writes the error on the
   error output and exits with code `84`.
2. It computes the generations, starting from generation 0, a single live
   cell.
3. It displays `--lines` generations, starting at generation `--start`.
   Without `--lines`, it never stops.
4. Each line shows `--window` cells around the centre of the automaton,
   translated by `--move` cells. Live cells are `*`, dead cells are spaces.

### Rules

- A cell's state in the next generation depends on its own state and on the
  state of its two neighbours. The 8 bits of the rule number give the new
  state for each of the 8 possible patterns (see
  [Elementary cellular automaton][eca]).
- Supported rules: 30, 90 and 110.
- The space is infinite to the left, to the right and to the bottom: cells
  outside the window still affect future generations.

[eca]: https://en.wikipedia.org/wiki/Elementary_cellular_automaton

## Getting Started

### Dependencies

- [Stack](https://docs.haskellstack.org/) 2.1.3 or later, with the
  `lts-16.16` resolver (it provides GHC)
- `make`
- git
- no library other than `base`
- a unit test framework (not chosen yet)
- lambdananas (the Epitech Haskell style checker),
  [hlint](https://github.com/ndmitchell/hlint) and
  [fourmolu](https://github.com/fourmolu/fourmolu), for linting

### Installing

```sh
git clone git@github.com:cambot-a/wolfram-Mint-CAMBOT.git
cd wolfram-Mint-CAMBOT
```

### Building

```sh
make                 # build binary
make re              # full rebuild
make clean / fclean  # remove object files / also remove the binaries
```

### Running

```sh
./wolfram --rule N [--start val] [--lines val] [--window val] [--move val]
```

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

On error (no option, an invalid option), the program displays a usage
message, writes the error on the error output and exits with code `84`.
Otherwise it exits with code `0`.

## Examples

```sh
./wolfram --rule 30 --lines 20              # 20 generations of rule 30
./wolfram --rule 90 --lines 20 --start 100  # generations 100 to 119 of rule 90
./wolfram --rule 30 --lines 10 --move 20    # rule 30, window translated by 20,
                                            # display only 20 generations
```

The expected outputs are in the subject (`docs/Subject/`).

## Development

### Project layout

```
.gitignore      ignored files
Makefile        make including re, clean, fclean, all rules at least
README.md       program user documentation
config/         the program config if it has one
docs/
  DFDs/         data flow diagrams related to the program's internals
                (programmer doc)
  Standard/     pdf/txt/md files related to the standard of the project
                (including style, CLAUDE.md, SDLC, philosophy...)
    Style/      pdf/txt/md files related to the coding style of the project
src/
  Shared/       project agnostic srcs
  Wolfram/      project srcs
tests/              unit and functional tests
```

New src files under src/Shared and src/Wolfram are picked up automatically

### Linting

```sh
make standard # lambdananas + fourmolu + hlint
```

`make standard` runs the three linters: lambdananas checks the Epitech Haskell
Coding Style, hlint suggests more idiomatic code, and fourmolu checks the
formatting. The code must pass all three before a commit.

### Tests

Development follows TDD:

- **Unit tests** use a framework that is not chosen yet.
- **Functional tests** run `wolfram` and compare its exact output with the
  expected one.

the TESTS section at the footer of this page lists every behaviour the tests
must cover:

- the exact console messages;

### Coding style & standard

The code follows the
[Epitech Haskell Coding Style][style],
checked with lambdananas and completed by hlint and fourmolu. The project's
working standard is in [docs/Standard/CLAUDE.md](docs/Standard/CLAUDE.md).

[style]: docs/Standard/Style/epitech_haskell_coding_style.pdf

### Roadmap

| Milestone | Days | Content |
|---|---|---|
| `build/stable_file_tree` | 1–2 | file tree, Makefile and Stack project |
| `ops/functionnal_testing` | 1–2 | functional testing |
| `feat/*` | 3–18 | main features |
| — | 19–21 | quality assurance and bonuses |

### AI usage

Under the project rules, no AI-generated code is used for the implementation.
AI may draft documentation (READMEs, Docs, comments), which the author then
reviews and rewrites.

## Help

No issues reported yet.

## Authors

Armand Cambot
GitHub: [@cambot-a](https://github.com/cambot-a)
LinkedIn: [@Armand Cambot][linkedin]

[linkedin]: https://www.linkedin.com/in/armand-cambot-epitech-developper/

## Version History

This is the pre-release.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE)
file for details.

## Acknowledgments

- [README-Template.md][template]

[template]: https://gist.github.com/DomPizzie/7a5ff55ffa9081f2de27c315f5018afc

## TESTS

### Building

-> `make` builds `wolfram` at the root of the repository
-> `stack.yaml` is at the root of the repository
-> `package.yaml` depends only on `base` in the lib and executable sections

### Coding style

-> lambdananas reports no violation

### Arguments

-> no option: usage message, exit code 84
-> `--rule` missing: usage message, exit code 84
-> unknown option: usage message, exit code 84
-> option without its value (`--rule`): usage message, exit code 84
-> non-numeric value (`--rule abc`, `--lines x`): usage message, exit code 84
-> errors are written on the error output
-> valid options: exit code 0

### Display

-> `--rule 30 --lines 20`: the subject's first example
-> `--rule 90 --lines 20 --start 100`: the subject's second example
-> `--rule 30 --lines 10 --move 20`: the subject's third example
-> without `--lines`: the program never stops
-> without `--window`: 80 cells per line
-> even `--window`: the central cell is displayed in the next cell on the
   right
-> negative `--move`: the window is translated to the left
-> positive `--move`: the window is translated to the right
