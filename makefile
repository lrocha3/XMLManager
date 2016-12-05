CC = g++

BIN = XMLManager.exe

INC_DIR = inc
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
LIB_DIR = lib
LIBS_INC ?=


#Ao definir o SRC e colocar a var
#OBJ apenas com os ficheiros
#que o SRC tem a compilação
#só vai criar os objectos que são
#necessários. Ficheiros dummy não
#são adicionados.

SRC = $(SRC_DIR)/main.cpp   \
	$(SRC_DIR)/client.cpp

OBJ  = $(SRC:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
#$(info $$OBJ is [${OBJ}]) to print var

TinyXML2_LIB_DIR = $(LIB_DIR)/tinyxml2/
TinyXML2_LIB_DLL_DIR = $(LIB_DIR)/tinyxml2/dll
TinyXML2_LIB_DLL_NAME = TinyXML2
TinyXML2_LIB_INC_DIR = $(LIB_DIR)/tinyxml2/inc

LIBS_INC += -I $(TinyXML2_LIB_INC_DIR)

#Add new libraries to copy dlls to bin path
ALL_LIBS_FILES = $(LIB_DIR)/tinyxml2/dll/$(TinyXML2_LIB_DLL_NAME).dll


INCFLAGS = -I $(INC_DIR)
INCFLAGS += $(LIBS_INC)


DEBUG = -g

#C++ Standard
CPPSTD = -std=c++11

#CFLAGS --> Creation of objects
CFLAGS = -Wall -c $(DEBUG) $(CPPSTD)
#LDFLAGS --> Linking Objects
LDFLAGS = -Wall $(DEBUG)

LDLIBS = -L$(TinyXML2_LIB_DLL_DIR)
LDLIBS += -l$(TinyXML2_LIB_DLL_NAME)
#? == nothing still

# $(LDLIBS) -o $@ from first to last calls the same command
#$^ calls every occurence of a lib for example in one command only



#Other way to create folders
#dummy_var := $(shell mkdir $(OBJ_DIR) -p))






all: prepare_environment $(BIN_DIR)/$(BIN) 

prepare_environment:
	mkdir $(OBJ_DIR) -p
	mkdir $(BIN_DIR) -p
	cd $(TinyXML2_LIB_DIR) && $(MAKE)
	cp $(ALL_LIBS_FILES) $(BIN_DIR)

$(BIN_DIR)/$(BIN): $(OBJ)
	$(info Linking objs to bin.)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp


$(OBJ): $(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(info Creating objs.)
	$(CC) $(INCFLAGS) $(CFLAGS) $< -o $@

clean:
	$(info Deleting objs and bin.)
	$(RM) $(OBJ) $(BIN_DIR)/$(BIN)

execute:
	@if test -f $(BIN_DIR)/$(BIN); then \
		./$(BIN_DIR)/$(BIN); \
	else \
		echo "No binary file!"; \
	fi

#if there is a file in the
#makefile directory with
#the name all, clean or execute
#the make all or make clean or make execute
#will be guaranted to be executed.

.PHONY: all clean execute
