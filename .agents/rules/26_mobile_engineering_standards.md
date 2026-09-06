# 26. Mobile Engineering Standards

When you need to write custom native platform channels, views, or integrate complex OS-level hardware for the Flutter application, strictly adhere to the following native engineering standards:

-   **Declarative Layout Transition (For Custom Native Views)**:
    -   **Android Compose**: For all new native screen mockups or native refactoring in Android development, use Jetpack Compose. Traditional XML layout files are deprecated. Ensure Compose state is hoisted and scoped to ViewModels.
    -   **iOS SwiftUI**: For all new native iOS layouts, use SwiftUI views. Avoid storyboard or raw UIKit unless bridging custom complex components. Ensure SwiftUI state management (`@State`, `@StateObject`, `@Binding`) is correctly utilized.
-   **Safe Custom Platform Bridges**:
    -   **Strict Threading & Serialization**: All Flutter custom native platform bridges (`MethodChannel` and `EventChannel`) written in Kotlin or Swift must explicitly run asynchronous tasks off the main thread (e.g., using Kotlin Coroutines on `Dispatchers.IO` or Swift background queues) to prevent UI blockages.
    -   **Result Thread Safety**: Ensure the channel result callback (e.g., `MethodChannel.Result` on Android or FlutterResult on iOS) is returned back on the UI thread (`Dispatchers.Main` / `@MainActor`).
-   **Memory Leak and Allocation Audits**:
    -   **Resource Cleanup**: All Native/Flutter async listeners, event streams, and background location services must implement explicit resource cancellation hooks.
    -   **Leak Scanning**: Proactively design for clean layout lifecycles. Ensure Kotlin Coroutines jobs are bound to `viewModelScope` / lifecycle scope and Swift Combine bindings are managed with `Set<AnyCancellable>`.
-   **Offline-First Data Storage Integrity**:
    -   **Structured Persistence**: If heavy local native storage is required, it must use Room DB (Android) or CoreData/Realm (iOS) with proper schema versioning and migrations. Direct file-based serialization for structural database entities is forbidden.
    -   **Queueing & Sync**: Any database modifications executed offline must be queued as pending transactions and synchronised sequentially using idempotent API requests with proper conflict resolution strategies.
-   **Edge AI Inference Optimization (For On-Device ML)**:
    -   **LiteRT & CoreML Quantization**: All custom on-device Machine Learning models (TFLite/LiteRT, Core ML, ExecuTorch) integrated natively must undergo INT8 or FP16 quantization to minimize APK/IPA bundle size and CPU/GPU memory footprint.
    -   **Hardware Acceleration**: ML models must specify delegates mapping execution to hardware-accelerated accelerators (Android NNAPI / Qualcomm DSP / Apple Neural Engine) whenever supported by the OS level.
    -   **Offline Generative AI Execution**: Local LLM inferences (via ONNX Runtime Mobile or MediaPipe LLM Inference API) must run asynchronously and provide streaming text tokens to prevent system UI lockups.