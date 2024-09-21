#!/bin/bash
mkdir -p ./../gen/
antlr4 -Dlanguage=Cpp -o ./../gen/ guava.g4