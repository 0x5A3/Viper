printf '
SRC_DIR := src
SRC := $(shell find $(SRC_DIR) -name "*.c")
HDR := $(shell find $(SRC_DIR) -name "*.h")

FLAGS := -Wall -Werror -pedantic

PHONY: lin
lin: $(SRC) $(HDR)
\t@gcc $(FLAGS) $(SRC) -o .bin/main

PNONY: lin_fast
lin_fast: $(SRC) $(HDR)
\t@gcc -Ofast $(FLAGS) $(SRC) -o .bin/main 

PHONY: debug
debug: $(SRC) $(HDR)
\t@gcc -g $(FLAGS) $(SRC) -o .bin/main
' > Makefile

clear
OPTION=$1
shift

case $OPTION in
    mem)
        make lin && valgrind --leak-check=full --track-origins=yes ./.bin/main "$@"
    ;;
    debug)
        make debug && gdb ./.bin/main "$@"
    ;;
    build)
        make lin && ./.bin/main "$@"
    ;;
    run)
        ./.bin/main "$@"
    ;;
    fast)
        make lin_fast && ./.bin/main "$@"
    ;;
esac