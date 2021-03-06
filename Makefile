SRC = shell.c
BIN = msh

CC = gcc
RM = rm -f

CFLAGS = -ggdb -O2
override CFLAGS += -Wall -pedantic -pipe -MMD

.PHONY: all
all: build

.PHONY: build
build: $(BIN)

.PHONY: rebuild
rebuild: | clean
	$(MAKE) -C . build

.PHONY: clean
clean:
	$(RM) $(BIN) $(wildcard $(BIN)-g*.tar) $(wildcard *.d)

$(BIN): $(SRC)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: archive
VER:=$(shell git rev-parse --verify --short HEAD 2>/dev/null)
PKG_NAME:=$(BIN)-g$(VER)
archive:
	git archive --prefix='$(PKG_NAME)/' HEAD > $(PKG_NAME).tar

-include $(wildcard *.d)
