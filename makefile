NAME=ueb
IDIR=./include
SDIR=./src 
CC=gcc
DBGCFLAGS=-g -fsanitize=address
DBGLDFLAGS=-fsanitize=address 
CFLAGS=-I$(IDIR) -Wall -pedantic $(DBGCFLAGS) -std=gnu99
LIBS=
TEST_LIBS=
LDFLAGS=$(DBGLDFLAGS) $(LIBS)

ODIR=obj
TEST_ODIR=obj/test
BDIR=bin
BNAME=$(NAME)
MAIN=main.o
TEST_MAIN=test.o
TEST_BNAME=testueb

BIN_INSTALL_DIR=/usr/local/bin
MAN_INSTALL_DIR=/usr/local/man

_OBJ = $(MAIN) ueb.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

all: bin test

$(ODIR)/%.o: src/%.c include/*.h
	mkdir -p $(@D)
	$(CC) -c -o $@ $< $(CFLAGS) $(LDFLAGS)

bin: $(OBJ)
	mkdir -p $(BDIR)
	$(CC) -o $(BDIR)/$(BNAME) $^ $(CFLAGS) $(LDFLAGS)

test:
	echo "building tests"
	make bin MAIN=$(TEST_MAIN) BNAME=$(TEST_BNAME) ODIR=$(TEST_ODIR) LIBS=$(TEST_LIBS)

.PHONY: clean

clean:
	rm -f ./$(ODIR)/*.o
	rm -f ./$(TEST_ODIR)/*.o
	rm -f ./$(BDIR)/$(BNAME)
	rm -f ./$(BDIR)/$(TEST_BNAME)

.PHONY: install 

install:
	cp ./$(BDIR)/$(BNAME) $(BIN_INSTALL_DIR)
	cp ./doc/$(BNAME).man $(MAN_INSTALL_DIR)

.PHONY: tags 
tags:
	ctags --recurse=yes --exclude=.git --exclude=bin --exclude=obj --extras=*  --fields=*  --c-kinds=* --language-force=C 

.PHONY:
ccmds:
	bear -- make SHELL="sh -x -e" --always-make

.PHONY: format
format:
	clang-format -i ./src/*.c ./include/*.h

.PHONY: lint 
lint:
	clang-tidy ./include/*.h ./src/*.c
	
.PHONY: runtest
runtest:
	./$(BDIR)/$(TEST_BNAME)
