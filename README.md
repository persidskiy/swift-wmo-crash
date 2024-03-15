Swift crashes when this project is built with enabled Whole Module Optimization and Testability.

Reprodution:
```
swift test -c release // crashes
swift test // no crash
```

Stacktrace
```
1.      Apple Swift version 5.10 (swiftlang-5.10.0.13 clang-1500.3.9.4)
2.      Compiling with the current language version
3.      While evaluating request ExecuteSILPipelineRequest(Run pipelines { PrepareOptimizationPasses, EarlyModulePasses, HighLevel,Function+EarlyLoopOpt, HighLevel,Module+StackPromote, MidLevel,Function, ClosureSpecialize, LowLevel,Function, LateLoopOpt, SIL Debug Info Generator } on SIL for swift_crash)
4.      While running pass #1244 SILModuleTransform "CrossModuleOptimization".
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  swift-frontend           0x0000000109de7f3c llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 56
1  swift-frontend           0x0000000109de70f8 llvm::sys::RunSignalHandlers() + 112
2  swift-frontend           0x0000000109de8544 SignalHandler(int) + 360
3  libsystem_platform.dylib 0x000000018d3f9a24 _sigtramp + 56
4  swift-frontend           0x0000000104f60fb4 swift::SILCloner<(anonymous namespace)::InstructionVisitor>::doesOpTupleDisappear(swift::CanTypeWrapper<swift::TupleType>) + 300
5  swift-frontend           0x0000000104f5b89c (anonymous namespace)::InstructionVisitor::makeTypesUsableFromInline(swift::SILInstruction*, (anonymous namespace)::CrossModuleOptimization&) + 4276
6  swift-frontend           0x0000000104f58fb0 (anonymous namespace)::CrossModuleOptimization::serializeFunction(swift::SILFunction*, llvm::DenseMap<swift::SILFunction*, bool, llvm::DenseMapInfo<swift::SILFunction*, void>, llvm::detail::DenseMapPair<swift::SILFunction*, bool>> const&) + 228
7  swift-frontend           0x0000000104f587f8 (anonymous namespace)::CrossModuleOptimizationPass::run() + 468
8  swift-frontend           0x0000000105120978 swift::SILPassManager::executePassPipelinePlan(swift::SILPassPipelinePlan const&) + 16476
9  swift-frontend           0x0000000105159354 swift::SimpleRequest<swift::ExecuteSILPipelineRequest, std::__1::tuple<> (swift::SILPipelineExecutionDescriptor), (swift::RequestFlags)1>::evaluateRequest(swift::ExecuteSILPipelineRequest const&, swift::Evaluator&) + 56
10 swift-frontend           0x000000010513d184 llvm::Expected<swift::ExecuteSILPipelineRequest::OutputType> swift::Evaluator::getResultUncached<swift::ExecuteSILPipelineRequest>(swift::ExecuteSILPipelineRequest const&) + 476
11 swift-frontend           0x000000010513fe94 swift::runSILOptimizationPasses(swift::SILModule&) + 504
12 swift-frontend           0x00000001048f516c swift::CompilerInstance::performSILProcessing(swift::SILModule*) + 1224
13 swift-frontend           0x00000001046e5f98 performCompileStepsPostSILGen(swift::CompilerInstance&, std::__1::unique_ptr<swift::SILModule, std::__1::default_delete<swift::SILModule>>, llvm::PointerUnion<swift::ModuleDecl*, swift::SourceFile*>, swift::PrimarySpecificPaths const&, int&, swift::FrontendObserver*) + 1128
14 swift-frontend           0x00000001046e5a18 swift::performCompileStepsPostSema(swift::CompilerInstance&, int&, swift::FrontendObserver*) + 2100
15 swift-frontend           0x00000001046e9694 performCompile(swift::CompilerInstance&, int&, swift::FrontendObserver*) + 1448
16 swift-frontend           0x00000001046e76d0 swift::performFrontend(llvm::ArrayRef<char const*>, char const*, void*, swift::FrontendObserver*) + 4968
17 swift-frontend           0x0000000104676e8c swift::mainEntry(int, char const**) + 2612
18 dyld                     0x000000018d0490e0 start + 2360
```
