all:
	java -cp ./antlr-3.5.2-complete-no-st3.jar org.antlr.Tool myCompiler.g
	javac -cp ./antlr-3.5.2-complete-no-st3.jar *.java
	
	java -cp ./antlr-3.5.2-complete-no-st3.jar:. myCompiler_test myInput1.c > myInput1.ll
	java -cp ./antlr-3.5.2-complete-no-st3.jar:. myCompiler_test myInput2.c > myInput2.ll
	java -cp ./antlr-3.5.2-complete-no-st3.jar:. myCompiler_test myInput3.c > myInput3.ll
	
	llc myInput1.ll
	llc myInput2.ll
	llc myInput3.ll

	gcc -static myInput1.s -o myInput1.exe
	gcc -static myInput2.s -o myInput2.exe
	gcc -static myInput3.s -o myInput3.exe
	
	@read -p "press enter to execute next program(myInput1.exe)" trash
	@echo "execute myInput1.exe"
	./myInput1.exe &
	
	@read -p "press enter to execute next program(myInput2.exe)" trash
	@echo "execute myInput2.exe"
	./myInput2.exe &
	
	@read -p "press enter to execute next program(myInput3.exe)" trash
	@echo "execute myInput3.exe"
	./myInput3.exe &
	
	@read -p "press enter to end Makefile" trash
	
clang:
	clang -S -emit-llvm myInput1.c -o standard_myInput1.ll
	clang -S -emit-llvm myInput2.c -o standard_myInput2.ll
	clang -S -emit-llvm myInput3.c -o standard_myInput3.ll

.PHONY: clean
clean:
	-rm ./myCompiler.tokens
	-rm ./myCompilerLexer.java
	-rm ./myCompilerParser.java
	-rm ./*.class
	-rm ./*.ll
	-rm ./*.s
	-rm ./*.exe
	
