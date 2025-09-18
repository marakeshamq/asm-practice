TARGET = hw1
ASM_SRC = $(TARGET).asm
OBJ_FILE = $(TARGET).o
EXEC_FILE = program

build:
	nasm -f elf32 $(ASM_SRC) -o $(OBJ_FILE)

link:
	ld -m elf_i386 $(OBJ_FILE) -o $(EXEC_FILE)

run:
	./$(EXEC_FILE)

all: build link run
