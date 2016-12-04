CC = g++

DLL = TinyXML2.dll

INC_DIR = inc
SRC_DIR = src
OBJ_DIR = obj
DLL_DIR = dll




SRC = $(SRC_DIR)/tinyxml2.cpp

OBJ  = $(SRC:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

INCFLAGS = -I $(INC_DIR)

#C++ Standard
CPPSTD = -std=c++11


#CFLAGS --> Creation of objects
CFLAGS = -Wall -c $(CPPSTD)
#LDFLAGS --> Linking Objects
LDFLAGS = -shared -Wall


all: prepare_environment $(DLL_DIR)/$(DLL)

prepare_environment:
#Create the object dir
	mkdir $(OBJ_DIR) -p
	mkdir $(DLL_DIR) -p

$(DLL_DIR)/$(DLL): $(OBJ)
	$(info Linking objs to bin.)
	$(CC) $(LDFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp

$(OBJ): $(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(info Creating objs.)
	$(CC) $(INCFLAGS) $(CFLAGS) $< -o $@

clean:
	$(info Deleting objs and bin.)
	$(RM) $(OBJ) $(DLL_DIR)/$(DLL)


.PHONY: all clean