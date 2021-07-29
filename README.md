A standard project structure for C and C++ projects with a perfect Makefile.

## `make <OPTION>`
- clean
- expand
- run
- test
- static
- dynamic
	-f PIC
		- Position Independent Code
	-shared

## Project Structure
### bin
- Structure
	- bin/main
	- bin/test
	- include/*
	- src/main.c
	- test/test.c

### lib
- lib doesn't have `src/main.c` or any module in `src` with `main` function.
- Structure
	- bin/test
	- include/*
	- lib/lib.a
	- lib/lib.so
	- test/test.c

## References
- <https://stackoverflow.com/questions/10024279/how-to-use-shell-commands-in-makefile>
- <https://stackoverflow.com/questions/3477292/what-do-and-do-as-prefixes-to-recipe-lines-in-make>
- [How to write your own code libraries in C.](https://youtu.be/JbHmin2Wtmc)