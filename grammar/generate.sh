#!/bin/bash
mkdir -p ./../gen/
antlr4 -Dlanguage=Cpp -o ./../gen/ Guava.g4
echo "Finished generating Guava parser"