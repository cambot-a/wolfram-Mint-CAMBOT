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
#	every Haskell file checked by the linters (tests/ and tmp/ left out)
HS_SRC	=	$(sort $(shell find $(APP_DIR) $(SRC_DIR) -type f -name '*.hs' \
		2>/dev/null))

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
REFACTOR	=	refactor
HLINT_FIX_FLAGS	=	--refactor --refactor-options=--inplace \
			--with-refactor=$(REFACTOR)
#	formatter, config in fourmolu.yaml (it has no parallel option)
FOURMOLU	=	fourmolu
FOURMOLU_FLAGS	=	--config fourmolu.yaml
#	checkers run by standard and para_standard, in this order
STANDARD_CHECKERS	=	lambdananas hlint formatlint
PARA_STANDARD_CHECKERS	=	lambdananas para_hlint formatlint
#	report colours
RED	=	\033[0;31m
GREEN	=	\033[0;32m
RESET	=	\033[0m
#	$(call check_tool,<command>): stops the rule if <command> is missing
check_tool	=	command -v $(1) >/dev/null 2>&1 || { printf \
		'$(RED)%s not found: install it first (see \
		docs/Standard/CLAUDE.md, 6)$(RESET)\n' '$(1)'; exit 1; }
#	$(call check_files,<rule>): ends the rule if there is no file to check
check_files	=	[ -n "$(HS_SRC)" ] || { printf '%s: no .hs file in \
		$(APP_DIR)/ or $(SRC_DIR)/\n' '$(1)'; exit 0; }

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RECIPES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

all: $(BIN)

re: fclean all

#             ~~~~~~~~~~~~~~~~~~~~~~~~ clean ~~~~~~~~~~~~~~~~~~~~~~~            

mostlyclean:	# Like 'clean', but refrains from deleting a few files that
#				  people normally don't want to recompile.

clean: mostlyclean

fclean: clean

#             ~~~~~~~~~~~~~~~~~~~~~~~~ binary ~~~~~~~~~~~~~~~~~~~~~~~           

$(BIN):

#             ~~~~~~~~~~~~~~~~~~ standard checkers ~~~~~~~~~~~~~~~~~            
#	Each one prints its full report and fails when it finds a violation.

lambdananas:
	@$(call check_tool,$(LAMBDANANAS)); \
	$(call check_files,lambdananas); \
	report=$$($(LAMBDANANAS) $(HS_SRC) 2>&1); \
	status=$$?; \
	if [ $$status -ne 0 ] || [ -n "$$report" ]; then \
		printf '$(RED)%s$(RESET)\n' "$$report"; \
		printf '$(RED)lambdananas: violations found$(RESET)\n'; \
		exit 1; \
	fi; \
	printf '$(GREEN)lambdananas: OK$(RESET)\n'

hlint:
	@$(call check_tool,$(HLINT)); \
	$(call check_files,hlint); \
	if $(HLINT) $(HLINT_FLAGS) $(HS_SRC); then \
		printf '$(GREEN)hlint: OK$(RESET)\n'; \
	else \
		printf '$(RED)hlint: violations found$(RESET)\n'; \
		exit 1; \
	fi

#	hlint on every core
para_hlint: HLINT_FLAGS += $(HLINT_PARA_FLAGS)
para_hlint: hlint

#	prints the diff fourmolu would apply
formatlint:
	@$(call check_tool,$(FOURMOLU)); \
	$(call check_files,formatlint); \
	if $(FOURMOLU) $(FOURMOLU_FLAGS) --mode check $(HS_SRC); then \
		printf '$(GREEN)formatlint: OK$(RESET)\n'; \
	else \
		printf '$(RED)formatlint: files not formatted$(RESET)\n'; \
		exit 1; \
	fi

#	runs every checker even when one fails, then fails if one of them did
standard:
	@failed=""; \
	for rule in $(STANDARD_CHECKERS); do \
		$(MAKE) --no-print-directory $$rule || failed="$$failed $$rule"; \
	done; \
	if [ -n "$$failed" ]; then \
		printf '$(RED)standard: failed:%s$(RESET)\n' "$$failed"; \
		exit 1; \
	fi; \
	printf '$(GREEN)standard: OK$(RESET)\n'

#	standard with the para_ checkers
para_standard: STANDARD_CHECKERS = $(PARA_STANDARD_CHECKERS)
para_standard: standard

#             ~~~~~~~~~~~~~~~~~~~ standard fixers ~~~~~~~~~~~~~~~~~~            
#	They rewrite the files in place: commit first. Not run by default.

#	shows the hints, then applies them file by file. The result may not
#	compile (e.g. a qualified name without its import): rebuild after it.
hlintfix:
	@$(call check_tool,$(HLINT)); \
	$(call check_tool,$(REFACTOR)); \
	$(call check_files,hlintfix); \
	$(HLINT) $(HLINT_FLAGS) $(HS_SRC); \
	for file in $(HS_SRC); do \
		$(HLINT) $(HLINT_FLAGS) $(HLINT_FIX_FLAGS) "$$file" || exit 1; \
	done; \
	printf '$(GREEN)hlintfix: hints applied$(RESET)\n'

#	shows the diff, then formats the files
formatfix:
	@$(call check_tool,$(FOURMOLU)); \
	$(call check_files,formatfix); \
	$(FOURMOLU) $(FOURMOLU_FLAGS) --mode check $(HS_SRC); \
	$(FOURMOLU) $(FOURMOLU_FLAGS) --mode inplace $(HS_SRC) || exit 1; \
	printf '$(GREEN)formatfix: files formatted$(RESET)\n'

#	hlint fixes first (their output is not formatted), then the formatter,
#	then standard shows what is left
fixall:
	@$(MAKE) --no-print-directory hlintfix && \
	$(MAKE) --no-print-directory formatfix && \
	$(MAKE) --no-print-directory standard

#             ~~~~~~~~~~~~~~~~~~~ special targets ~~~~~~~~~~~~~~~~~~            

.PHONY: all clean fclean re lambdananas hlint para_hlint formatlint standard \
	para_standard hlintfix formatfix fixall

.NOTPARALLEL: re fixall
