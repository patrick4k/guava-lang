#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/raw_ostream.h>

#include "GuavaParserInclude.h"

int main() {
    // 1. Initialize LLVM components
    llvm::LLVMContext context;
    llvm::Module* module = new llvm::Module("simple_module", context);
    llvm::IRBuilder<> builder(context);

    // 2. Define the function prototype (int add(int a, int b))
    llvm::FunctionType* funcType = llvm::FunctionType::get(
        builder.getInt32Ty(), // Return type: int32
        {builder.getInt32Ty(), builder.getInt32Ty()}, // Arguments: two int32s
        false // Not a variadic function
    );
    
    llvm::Function* addFunc = llvm::Function::Create(
        funcType, llvm::Function::ExternalLinkage, "add", module
    );
    
    // 3. Create a new basic block to insert instructions into
    llvm::BasicBlock* block = llvm::BasicBlock::Create(context, "entry", addFunc);
    builder.SetInsertPoint(block);

    // 4. Get the function's arguments and name them
    llvm::Function::arg_iterator args = addFunc->arg_begin();
    llvm::Value* a = args++;
    a->setName("a");
    llvm::Value* b = args++;
    b->setName("b");

    // 5. Create the "add" instruction (a + b)
    llvm::Value* sum = builder.CreateAdd(a, b, "sum");

    // 6. Return the result of the addition
    builder.CreateRet(sum);

    // 7. Validate the generated code
    llvm::verifyFunction(*addFunc);

    // 8. Output the generated LLVM IR
    module->print(llvm::outs(), nullptr);

    // Clean up
    delete module;
    
    return 0;
}
