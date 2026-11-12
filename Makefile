##
## EPITECH PROJECT, 2026
## Makefile
## File description:
## Makefile
##

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VARIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#             ~~~~~~~~~~~~~~~~~~~~ src variables ~~~~~~~~~~~~~~~~~~~            
#	app/ holds the main, src/ the rest of the code
APP_DIR	=	app
SRC_DIR	=	src
#	every Haskell file checked by the linters (test/ and tmp/ left out)
HS_SRC	=	$(sort $(shell find $(APP_DIR) $(SRC_DIR) -type f -name '*.hs' \
		2>/dev/null))
STACK_BIN_PATH	=	$(shell stack path --local-install-root)/bin/$(BIN)

#             ~~~~~~~~~~~~ conventionnal makefile flags ~~~~~~~~~~~~     

SHELL = /bin/sh
MAKE	=	make

#             ~~~~~~~~~~~~~~~~~~~ compiler values ~~~~~~~~~~~~~~~~~~            

#             ~~~~~~~~~~~~~~~~~~~~~ bin name(s) ~~~~~~~~~~~~~~~~~~~~            

BIN	=	wolfram

#             ~~~~~~~~~~~~~~~~~~~~~~~ linters ~~~~~~~~~~~~~~~~~~~~~~            
#	Epitech style checker: it always exits with 0, so its rule fails as soon
#	as it prints something
LAMBDANANAS	=	lambdananas
#	hlint, config in .hlint.yaml
HLINT	=	hlint
HLINT_FLAGS	=	--hint=.hlint.yaml
#	-j: one thread per core (para_ rules)
HLINT_PARA_FLAGS	=	-j
#	apply-refact, the tool hlint calls to apply its hints (hlintfix)
HLINT_FIX_FLAGS	=	--refactor --refactor-options=--inplace \
			--with-refactor=refactor
#	formatter, config in fourmolu.yaml (it has no parallel option)
FOURMOLU	=	fourmolu
FOURMOLU_FLAGS	=	--config fourmolu.yaml
#	checkers run by standard and para_standard, in this order
STANDARD_CHECKERS	=	lambdananas hlint formatlint
PARA_STANDARD_CHECKERS	=	lambdananas para_hlint formatlint
#	report colours
RED	=	\033[0;31m
RESET	=	\033[0m
#	$(call check_tool,<command>): stops the rule if <command> is missing
check_tool	=	command -v $(1) >/dev/null 2>&1 || { printf \
		'$(RED)%s not found: install it first (see \
		docs/Standard/CLAUDE.md, 6)$(RESET)\n' '$(1)'; exit 1; }

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RECIPES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

all: $(BIN)

re: fclean all

#             ~~~~~~~~~~~~~~~~~~~~~~~~ clean ~~~~~~~~~~~~~~~~~~~~~~~            

mostlyclean:	# Like 'clean', but refrains from deleting a few files that
#				  people normally don't want to recompile.

clean: mostlyclean

fclean: clean
	rm $(BIN)

#             ~~~~~~~~~~~~~~~~~~~~~~~~ binary ~~~~~~~~~~~~~~~~~~~~~~~           

$(BIN):
	stack build
	cp $(STACK_BIN_PATH) ./

#             ~~~~~~~~~~~~~~~~~~ standard checkers ~~~~~~~~~~~~~~~~~            
#	Each one prints its full report and fails when it finds a violation.

check_dev_deps:
	@$(call check_tool,lambdananas)
	@$(call check_tool,hlint)
	@$(call check_tool,fourmolu)
	@$(call check_tool,refactor)

lambdananas: check_dev_deps
	$(LAMBDANANAS) $(HS_SRC)

hlint: check_dev_deps
	-$(HLINT) $(HLINT_FLAGS) $(HS_SRC)

#	hlint on every core
para_hlint: HLINT_FLAGS += $(HLINT_PARA_FLAGS)
para_hlint: hlint

#	prints the diff fourmolu would apply
formatlint: check_dev_deps
	-$(FOURMOLU) $(FOURMOLU_FLAGS) --mode check $(HS_SRC)

#	runs every checker even when one fails, then fails if one of them did
standard: lambdananas hlint formatlint

#	standard with the para_ checkers
para_standard: lambdananas para_hlint formatlint

#             ~~~~~~~~~~~~~~~~~~~ standard fixers ~~~~~~~~~~~~~~~~~~            
#	They rewrite the files in place: commit first. Not run by default.

#	shows the hints, then applies them file by file. The result may not
#	compile (e.g. a qualified name without its import): rebuild after it.
hlintfix: hlint
	$(HLINT) $(HLINT_FLAGS) $(HLINT_FIX_FLAGS) $(HS_SRC)

#	shows the diff, then formats the files
formatfix: formatlint
	$(FOURMOLU) $(FOURMOLU_FLAGS) --mode inplace $(HS_SRC)

#	hlint fixes first (their output is not formatted), then the formatter,
#	then standard shows what is left
fixall: hlintfix formatfix standard

#             ~~~~~~~~~~~~~~~~~~~ special targets ~~~~~~~~~~~~~~~~~~            

.PHONY: all clean fclean re lambdananas hlint para_hlint formatlint standard \
	para_standard hlintfix formatfix fixall check_dev_deps

.NOTPARALLEL: re fixall check_dev_deps
