##
## EPITECH PROJECT, 2026
## Makefile
## File description:
## Makefile
##

## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VARIABLES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#             ~~~~~~~~~~~~~~~~~~~~ src variables ~~~~~~~~~~~~~~~~~~~            

#             ~~~~~~~~~~~~ conventionnal makefile flags ~~~~~~~~~~~~     

SHELL = /bin/sh
MAKE	=	make

#             ~~~~~~~~~~~~~~~~~~~ compiler values ~~~~~~~~~~~~~~~~~~            

#             ~~~~~~~~~~~~~~~~~~~~~ bin name(s) ~~~~~~~~~~~~~~~~~~~~            

BIN	=	FILL_BINARY_NAME

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

#             ~~~~~~~~~~~~~~~~~~~ special targets ~~~~~~~~~~~~~~~~~~            

.PHONY: all clean fclean re

.NOTPARALLEL: re
