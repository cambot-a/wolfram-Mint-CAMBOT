##
## EPITECH PROJECT, 2026
## Makefile
## File description:
## Makefile
##

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VARIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#             ~~~~~~~~~~~~~~~~~~~~~~~~ mains ~~~~~~~~~~~~~~~~~~~~~~~            
MAINS_DIR	=	mains
MAINS_SRC	=	$(sort $(shell find $(MAINS_DIR) -type f -name '*.cpp'))

#             ~~~~~~~~~~~~~~~~~~~~~~~~ mains ~~~~~~~~~~~~~~~~~~~~~~~            
OBJ_DIR	=	../../debugObjs
OBJ	=	$(filter-out %/main.o, $(sort $(shell find $(OBJ_DIR) -type f -name '*.o')))

#             ~~~~~~~~~~~~ conventionnal makefile flags ~~~~~~~~~~~~            
SHELL = /bin/sh
MAKE	=	make

#             ~~~~~~~~~~~~~~~~~~ linker variables ~~~~~~~~~~~~~~~~~~            
LDFLAGS	=	-L./
LDLIBS	=	-lgcov # -l...

#             ~~~~~~~~~~~~~~~~~~~ compiler values ~~~~~~~~~~~~~~~~~~            
CXX	=	g++
CXXFLAGS	=	-std=c++20 -Wall -Wextra -Wpedantic -O0 -g3 # CPP (compiler) FLAGS
CPPFLAGS	=	-iquote../../include -DDEBUG # C(lang) P(re) P(rocessor) FLAGS

#             ~~~~~~~~~~~~~~~~~~~~~ bin name(s) ~~~~~~~~~~~~~~~~~~~~            
MAINS_BINS	:=	$(notdir $(MAINS_SRC:%.cpp=%.out))

#             ~~~~~~~~~~~~~~~~~~~~~~~~ libs ~~~~~~~~~~~~~~~~~~~~~~~~            
LIBS	=	# libfoo.a ...

#             ~~~~~~~~~~~~ clang linter/fixer commands ~~~~~~~~~~~~~            
CLANG_TIDY	=	clang-tidy
CLANG_TIDY_FLAGS	=	--config-file=../../.clang-tidy -p=.
#	parallel clang-tidy (one job per core by default)
RUN_CLANG_TIDY	=	run-clang-tidy
RUN_CLANG_TIDY_JOBS	=	$(shell nproc)
RUN_CLANG_TIDY_FLAGS	=	\
	-config-file=../../.clang-tidy -p=. -j $(RUN_CLANG_TIDY_JOBS) -quiet
CLANG_FORMAT	=	clang-format

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RECIPES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#             ~~~~~~~~~~~~~~~~~~~ standard recipes ~~~~~~~~~~~~~~~~~            

all: parentobjs $(MAINS_BINS)

re: fclean parentobjs_fclean all

#             ~~~~~~~~~~~~~~~~~ clang linter/fixer ~~~~~~~~~~~~~~~~~            

compile_commands.json: fclean
	bear -- make re

tidylint: compile_commands.json
	$(CLANG_TIDY) $(CLANG_TIDY_FLAGS) $(MAINS_SRC)

formatlint: compile_commands.json
	$(CLANG_FORMAT) --dry-run $(MAINS_SRC)

tidyfix: compile_commands.json
	$(CLANG_TIDY) $(CLANG_TIDY_FLAGS) -fix $(MAINS_SRC)

formatfix: compile_commands.json
	$(CLANG_FORMAT) -i $(MAINS_SRC)

lintall: tidylint formatlint

fixall: tidyfix formatlint formatfix

#	parallel versions: run-clang-tidy lints every file of compile_commands.json
para_tidylint: compile_commands.json
	$(RUN_CLANG_TIDY) $(RUN_CLANG_TIDY_FLAGS) $(MAINS_SRC)

para_tidyfix: compile_commands.json
	$(RUN_CLANG_TIDY) $(RUN_CLANG_TIDY_FLAGS) -fix $(MAINS_SRC)

para_fixall: para_tidyfix formatlint formatfix

#             ~~~~~~~~~~~~~~~~~~~~~~~~ clean ~~~~~~~~~~~~~~~~~~~~~~~            

mostlyclean:	# Like 'clean', but refrains from deleting a few files that
#				  people normally don’t want to recompile.

clean: mostlyclean
	$(RM) compile_commands.json

fclean: clean
	$(RM) $(MAINS_BINS)

clear:
	mv $(sort $(shell find ./ -maxdepth 1 -type f -name '*.out')) ./trash_bin

binclean:
	$(RM) $(sort $(shell find ./trash_bin -type f -name '*.out'))

fclear: clear binclean

#             ~~~~~~~~~~~~~~~~~~~~~~~ binaries ~~~~~~~~~~~~~~~~~~~~~            

parentobjs:
	make -C ../../ debug

parentobjs_fclean:
	make -C ../../ debug_fclean

vpath %.cpp $(sort $(dir $(MAINS_SRC)))

%.out: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(LDFLAGS) $(CPPFLAGS) $(CXXFLAGS)	\
		-o $@ $(OBJ) $< $(LDLIBS)

$(DEBUG_OBJ_DIR)/%.o: %.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<


#             ~~~~~~~~~~~~~~~~~~~~~~ libraries ~~~~~~~~~~~~~~~~~~~~~            

libs: $(LIBS)

lib%.a:
	make -C ../../libs/lib$*

#             ~~~~~~~~~~~~~~~~~~~ special targets ~~~~~~~~~~~~~~~~~~            

.PHONY: tidylint formatlint tidyfix formatfix lintall all re parentobjs_fclean \
		libs para_tidylint para_tidyfix para_fixall parentobjs mostlyclean \
		clean fixall fclean clear fclear binclean

.NOTPARALLEL: re lintall fixall para_fixall
