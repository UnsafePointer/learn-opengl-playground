CXX		  := g++
CXX_FLAGS := -Wall -Wextra -std=c++17 -ggdb `pkg-config --cflags glfw3`

OPENGL_API := 3.3
GLAD_BUILD_DIR := glad

BIN		:= bin
SRC		:= src
INCLUDE	:= include
LIB		:= lib

LIBRARIES	:= -ldl `pkg-config --static --libs glfw3`
EXECUTABLE	:= renderer


all: $(BIN)/$(EXECUTABLE)

run: clean all
	clear
	./$(BIN)/$(EXECUTABLE)

$(GLAD_BUILD_DIR)/src/*.c:
	python -m glad --out-path=$(GLAD_BUILD_DIR) --profile=core --api="gl=$(OPENGL_API)" --extensions="GL_KHR_debug" --generator="c"

$(BIN)/$(EXECUTABLE): $(SRC)/*.cpp $(GLAD_BUILD_DIR)/src/*.c
	$(CXX) $(CXX_FLAGS) -I$(INCLUDE) -I$(GLAD_BUILD_DIR)/include -L$(LIB) $^ -o $@ $(LIBRARIES)

clean:
	rm -rf $(BIN)/*
	rm -rf $(GLAD_BUILD_DIR)
