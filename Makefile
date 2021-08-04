# [package]
NAME := sum
VERSION := 0.1.0
EDITION := 2021

SRC_EXT := cpp
HDR_EXT := hpp

AR := ar

MAIN := main
LIB := lib
TEST := test

SRC_DIR := src
INC_DIR := include
LIB_DIR := lib
OBJ_DIR := build
BIN_DIR := bin

TST_DIR := tests
TBN_DIR := tests/bin

CC := g++
# CC := clang --analyze
CC_FLAGS := -g -Wall
CC_INC := -I $(INC_DIR)
CC_LIBS :=


# Ignore $(MAIN).$(SRCEXT), test.c, and any $(SRCEXT) files starting with an underscore.
# SRC_FILES := $(wildcard $(SRC_DIR)/*.$(SRC_EXT))
SOURCES := $(shell find $(SRC_DIR) -type f ! -name $(MAIN).$(SRC_EXT) ! -name $(TEST)_*.$(SRC_EXT) ! -name _* -name *.$(SRC_EXT))
OBJECTS := $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SOURCES:.$(SRC_EXT)=.o))

TESTS := $(shell find $(TST_DIR) -type f ! -name $(MAIN).$(SRCEXT) ! -name $(TEST).$(SRCEXT) ! -name _* -name *.$(SRCEXT))

.PHONY: all clean test


all: build

build: $(BIN_DIR)/$(NAME)

clean:
	@echo '[+] Cleaning'
	$(RM) -rf -- $(BIN_DIR) $(OBJ_DIR)

expand: $(SRC_DIR)/$(MAIN).$(SRCEXT)
	@echo '[+] Expanding'
	$(CC) $(INCLUDE) -E $^

run: build
	@echo '[+] Running'
	@exec ./$(BINDIR)/$(MAIN)

test: $(TBN_DIR)/$(TEST)

dynamic: $(LIB_DIR)/lib$(NAME).so

static: $(LIB_DIR)/lib$(NAME).a

$(LIB_DIR)/lib$(NAME).so: $(OBJECTS)
	@mkdir -pv $(LIB_DIR)
	$(CC) $(CC_FLAGS) $(CC_INC) -fPIC -shared -o $@ $^ -lc

$(LIB_DIR)/lib$(NAME).a: $(OBJECTS)
	@mkdir -pv $(LIB_DIR)
	$(AR) rcs $@ $^ -lc

$(BIN_DIR)/$(NAME): $(SRC_DIR)/$(MAIN).$(SRC_EXT) $(OBJECTS)
	@echo '[+] Building'
	@mkdir -pv $(BIN_DIR)
	$(CC) $(CC_FLAGS) $(CC_INC) -o $@ $^ $(CC_LIBS)

$(BIN_DIR)/$(TEST): $(TST_DIR)/$(TEST).$(SRC_EXT) $(OBJECTS)
	@echo '[+] Testing'
	@mkdir -pv $(BIN_DIR)
	$(CC) $(CC_FLAGS) $(CC_INC) -o $@ $^ $(CC_LIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT)
	@echo '[+] Compiling'
	@mkdir -pv $(shell dirname $@)
	$(CC) $(CC_FLAGS) $(CC_INC) -c -o $@ $<