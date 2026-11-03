##
## EPITECH PROJECT, 2026
## Makefile
## File description:
## Makefile
##

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VARIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#             ~~~~~~~~~~~~~~~~~~~~ src variables ~~~~~~~~~~~~~~~~~~~            
#	shared src (potentially aggregate into libs later)
SRC_DIR	=	src

SHARED_SRC_DIR	=	$(SRC_DIR)/SharedSrc
SHARED_SRC	=	$(sort $(shell find $(SHARED_SRC_DIR) -type f -name '*.cpp'))
SHARED_OBJ	=	$(SHARED_SRC:%.cpp=%.o)

#	server
SERVER_SRC_DIR	=	$(SRC_DIR)/Server
SERVER_SRC	:=	$(sort $(shell find $(SERVER_SRC_DIR) -type f -name '*.cpp'))
SERVER_OBJ	:=	$(SERVER_SRC:%.cpp=%.o)

#	client
CLIENT_SRC_DIR	=	$(SRC_DIR)/Client
CLIENT_SRC	:=	$(sort $(shell find $(CLIENT_SRC_DIR) -type f -name '*.cpp'))
CLIENT_OBJ	:=	$(CLIENT_SRC:%.cpp=%.o)

#	global file lists
SRC	=	$(SHARED_SRC) $(SERVER_SRC) $(CLIENT_SRC)
OBJ	=	$(SHARED_OBJ) $(SERVER_OBJ) $(CLIENT_OBJ)
HEADERS	=	$(sort $(shell find ./include -type f -name '*.hpp'))
PROJECT_FILES	=	$(SRC) $(HEADERS)

#             ~~~~~~~~~~~~ conventionnal makefile flags ~~~~~~~~~~~~            
SHELL = /bin/sh
MAKE	=	make

#             ~~~~~~~~~~~~~~~~~~ linker variables ~~~~~~~~~~~~~~~~~~            
LDFLAGS	=	-L./
LDLIBS	=	# -l...

#             ~~~~~~~~~~~~~~~~~~~ compiler values ~~~~~~~~~~~~~~~~~~            
CXX	=	g++
CXXFLAGS	=	-std=c++20 -Wall -Wextra -Wpedantic -O0 # CPP (compiler) FLAGS
CPPFLAGS	=	-iquote./include # C(lang) P(re) P(rocessor) FLAGS

#             ~~~~~~~~~~~~~~~~~~~~~ bin name(s) ~~~~~~~~~~~~~~~~~~~~            
SERVER_BIN	=	epikh_server
CLIENT_BIN	=	epikh_client

#             ~~~~~~~~~~~~~~~~~~~~~~~~ libs ~~~~~~~~~~~~~~~~~~~~~~~~            
LIBS	=	# libfoo.a ...

#             ~~~~~~~~~~~~ clang linter/fixer commands ~~~~~~~~~~~~~            
CLANG_TIDY	=	clang-tidy
CLANG_TIDY_FLAGS	=	--config-file=.clang-tidy -p=.
#	parallel clang-tidy (one job per core by default)
RUN_CLANG_TIDY	=	run-clang-tidy
RUN_CLANG_TIDY_JOBS	=	$(shell nproc)
RUN_CLANG_TIDY_FLAGS	=	\
	-config-file=.clang-tidy -p=. -j $(RUN_CLANG_TIDY_JOBS) -quiet
CLANG_FORMAT	=	clang-format

#             ~~~~~~~~~~~~~~~~~~~~~~~ debug ~~~~~~~~~~~~~~~~~~~~~~~~            
DEBUG_OBJ_DIR	=	debugObjs
DEBUG_CPPFLAGS += -DDEBUG
DEBUG_CXXFLAGS += -g3 --coverage
DEBUG_LDLIBS	=	-lcriterion
GCOVR_OUT	=	.coverage.txt
DEBUG_SHARED_OBJ	=	$(addprefix $(DEBUG_OBJ_DIR)/, $(SHARED_OBJ))
DEBUG_SERVER_OBJ	=	$(addprefix $(DEBUG_OBJ_DIR)/, $(SERVER_OBJ))
DEBUG_CLIENT_OBJ	=	$(addprefix $(DEBUG_OBJ_DIR)/, $(CLIENT_OBJ))
TEST_SRC	=	$(sort $(shell find ./tests -type f -name '*.cpp'))
TESTS_BIN	=	crit_tests

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RECIPES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#             ~~~~~~~~~~~~~~~~~~~ standard recipes ~~~~~~~~~~~~~~~~~            

all: $(SERVER_BIN) $(CLIENT_BIN)

re: fclean all

#             ~~~~~~~~~~~~~~~~~ clang linter/fixer ~~~~~~~~~~~~~~~~~            

compile_commands.json: fclean
	bear -- make re

tidylint: compile_commands.json
	$(CLANG_TIDY) $(CLANG_TIDY_FLAGS) $(PROJECT_FILES)

formatlint: compile_commands.json
	$(CLANG_FORMAT) --dry-run $(SRC)

tidyfix: compile_commands.json
	$(CLANG_TIDY) $(CLANG_TIDY_FLAGS) -fix $(PROJECT_FILES)

formatfix: compile_commands.json
	$(CLANG_FORMAT) -i $(SRC)

lintall: tidylint formatlint

fixall: tidyfix formatlint formatfix

#	parallel versions: run-clang-tidy lints every file of compile_commands.json
para_tidylint: compile_commands.json
	$(RUN_CLANG_TIDY) $(RUN_CLANG_TIDY_FLAGS) $(SRC)

para_tidyfix: compile_commands.json
	$(RUN_CLANG_TIDY) $(RUN_CLANG_TIDY_FLAGS) -fix $(SRC)

para_fixall: para_tidyfix formatlint formatfix

#             ~~~~~~~~~~~~~~~~~~~~~~~~ clean ~~~~~~~~~~~~~~~~~~~~~~~            

mostlyclean:	# Like 'clean', but refrains from deleting a few files that
#				  people normally don’t want to recompile.
	$(RM) $(SHARED_OBJ) $(CLIENT_OBJ) $(SERVER_OBJ) $(GCOVR_OUT)

clean: mostlyclean

fclean: clean docs_fclean debug_fclean
	$(RM) $(SERVER_BIN) $(CLIENT_BIN) compile_commands.json

#             ~~~~~~~~~~~~~~~~~~~~~~~ binaries ~~~~~~~~~~~~~~~~~~~~~            

$(SERVER_BIN): $(SHARED_OBJ) $(SERVER_OBJ)
	$(CXX) $(LDFLAGS) $(CPPFLAGS) $(CXXFLAGS)	\
		-o $(SERVER_BIN) $(SHARED_OBJ) $(SERVER_OBJ) $(LDLIBS)

$(CLIENT_BIN): $(SHARED_OBJ) $(CLIENT_OBJ)
	$(CXX) $(LDFLAGS) $(CPPFLAGS) $(CXXFLAGS)	\
		-o $(CLIENT_BIN) $(SHARED_OBJ) $(CLIENT_OBJ) $(LDLIBS)

$(SERVER_BIN).debug: $(DEBUG_SHARED_OBJ) $(DEBUG_SERVER_OBJ)
	$(CXX) $(LDFLAGS) $(CPPFLAGS) $(DEBUG_CPPFLAGS) $(CXXFLAGS)	\
		$(DEBUG_CXXFLAGS)	\
		-o $(SERVER_BIN).debug $(DEBUG_SHARED_OBJ) $(DEBUG_SERVER_OBJ) $(LDLIBS)

$(CLIENT_BIN).debug: $(DEBUG_SHARED_OBJ) $(DEBUG_CLIENT_OBJ)
	$(CXX) $(LDFLAGS) $(CPPFLAGS) $(DEBUG_CPPFLAGS) $(CXXFLAGS)	\
		$(DEBUG_CXXFLAGS)	\
		-o $(CLIENT_BIN).debug $(DEBUG_SHARED_OBJ) $(DEBUG_CLIENT_OBJ) $(LDLIBS)

#             ~~~~~~~~~~~~~~~~~~~~~~ libraries ~~~~~~~~~~~~~~~~~~~~~            

libs: $(LIBS)

lib%.a:
	make -C libs/lib$*

#             ~~~~~~~~~~~~~~~~~~~~~~ debug ~~~~~~~~~~~~~~~~~~~~~~~~~            

$(DEBUG_OBJ_DIR)/%.o: CPPFLAGS += $(DEBUG_CPPFLAGS)
$(DEBUG_OBJ_DIR)/%.o: CXXFLAGS += $(DEBUG_CXXFLAGS)
$(DEBUG_OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

debug_clean:
	$(RM) -r $(DEBUG_OBJ_DIR)

debug_fclean: debug_clean
	$(RM) $(SERVER_BIN).debug $(CLIENT_BIN).debug $(TESTS_BIN)
	$(RM) $(TESTS_BIN)-*.gcda $(TESTS_BIN)-*.gcno

debug: $(SERVER_BIN).debug $(CLIENT_BIN).debug

debug_re: debug_fclean debug

#             ~~~~~~~~~~~~~~~~~~~~~~~~ tests ~~~~~~~~~~~~~~~~~~~~~~~            

# criterion
$(TESTS_BIN): LDLIBS += $(DEBUG_LDLIBS)
$(TESTS_BIN): DEBUG_SERVER_OBJ :=	\
	$(filter-out $(DEBUG_OBJ_DIR)/src/Server/main.o, $(DEBUG_SERVER_OBJ))
$(TESTS_BIN): DEBUG_CLIENT_OBJ :=	\
	$(filter-out $(DEBUG_OBJ_DIR)/src/Client/main.o, $(DEBUG_CLIENT_OBJ))
$(TESTS_BIN):	$(DEBUG_SHARED_OBJ) $(DEBUG_SERVER_OBJ)	\
				$(DEBUG_CLIENT_OBJ) $(TEST_SRC)
	$(CXX) $(LDFLAGS) $(CPPFLAGS) $(DEBUG_CPPFLAGS) $(CXXFLAGS)	\
		$(DEBUG_CXXFLAGS) -o $(TESTS_BIN) $(DEBUG_SHARED_OBJ)	\
		$(DEBUG_SERVER_OBJ) $(DEBUG_CLIENT_OBJ) $(TEST_SRC) $(LDLIBS)

# coverage
$(GCOVR_OUT): $(TESTS_BIN)
	./$(TESTS_BIN)
	gcovr --txt $(GCOVR_OUT)

# all
tests_run: $(TESTS_BIN) $(GCOVR_OUT)
	@cat $(GCOVR_OUT)

#             ~~~~~~~~~~~~~~~~~~~~~~~~ docs ~~~~~~~~~~~~~~~~~~~~~~~~            

docs:
	doxygen Doxyfile

docs_fclean:
	$(RM) -r docs/html

docs_re: docs_fclean docs

#             ~~~~~~~~~~~~~~~~~~~ special targets ~~~~~~~~~~~~~~~~~~            

.PHONY: all clean debug docs docs_fclean docs_re fclean fixall formatfix	\
		formatlint libs lintall mostlyclean re tests_run tidyfix tidylint 	\
		debug_clean debug_fclean debug_re para_tidylint para_tidyfix		\
		para_fixall

.NOTPARALLEL: re lintall fixall para_fixall
