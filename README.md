# PROJECT_NAME

// short description of the project

## Description

Running `make` builds // fill

**`FILL_BINARY_NAME [arg] [arg] [arg]`** // what does it do

### OTHER CHAPTER

### AND ANOTHER CHAPTER

## Getting Started

### Dependencies

- `COMPILER` // with version
- `make`
- git
- [FRAMEWORKS]
- [TESTER](https://...), for unit tests
- `LINTER`

### Installing

```sh
git clone git@github.com:cambot-a/PROJECT_NAME.git
cd PROJECT_NAME
```

### Building

```sh
make                 # build binary
make re              # full rebuild
make clean / fclean  # remove object files / also remove the binaries
```

### Running

```sh
./FILL_BINARY_NAME [arg] [arg] [arg]
```

- `arg`: // what is it?
- `arg`: // what is it?
- `arg`: // what is it?

On error, program exits with code `84`.

## CONFIG?

```
// sample
```

// Rules
- ...

## Development

### Project layout

```
.gitignore      ignored files
Makefile        make including re, clean, fclean, all rules at least
README.md       program user documentation
config/         the program config if it has one
docs/
  DFDs/         data flow diagrams related to the program's internals (programmer doc)
  Standard/     pdf/txt/md files related to the standard of the project (including style, CLAUDE.md, SDLC, philosophy...)
    Style/      pdf/txt/md files related to the coding style of the project
src/
  Shared/       project agnostic srcs
  PROJECT_NAME/ project srcs
tests/              unit and functional tests
```

New src files under src/Shared and src/PROJECT_NAME are picked up automatically

### Linting

```sh
make LINTER_RULE # FRAMEWORK
```

// explain

### Tests

Development follows TDD:

- **Unit tests** use TESTING FRAMEWORK.

the TESTS section at the footer of this page lists every behaviour the tests must cover:

- the exact console messages;

### Coding style & standard

### Roadmap

| Milestone | Days | Content |
|---|---|---|
// fill

### AI usage

Under the project rules, no AI-generated code is used for the implementation. AI may draft documentation (READMEs, Docs, comments), which the author then reviews and rewrites.

## Help

No issues reported yet.

## Authors

nor_ant
GitHub: [@cambot-a](https://github.com/cambot-a)

## Version History

This is the pre-release.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [README-Template.md](https://gist.github.com/DomPizzie/7a5ff55ffa9081f2de27c315f5018afc)

## TESTS
