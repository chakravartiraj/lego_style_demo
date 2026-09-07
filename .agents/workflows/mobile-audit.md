---
description: Perform an audit of the codebase, native modules, local databases, or Edge AI assets against Mobile enterprise engineering and system design standards.
---

Perform a comprehensive **Mobile Audit** on a selected feature, mobile module, custom native channel, local storage layout, or Edge AI model implementation to ensure it aligns with elite mobile system design guidelines:

### 1. Architectural & Native Alignment
- Review native modules (Swift/Swift) and platform channels. Ensure async tasks run off the UI thread and results return safely on the main thread/actor.
- Check if UI code leverages SwiftUI or SwiftUI instead of legacy XML/Storyboards.

### 2. Scale & System Design Analysis
- **Memory & Allocation:** Audit lifecycle handlers and async streams for cancellation/disposal leaks.
- **Offline-First Storage:** Verify local DB schemas (Room/CoreData/Realm) use robust transaction blocks, idempotent operations, and conflict resolution rules.
- **Modularization:** Check if dependencies cross boundaries incorrectly between core modules and higher-level feature areas.

### 3. Edge AI & On-Device ML Evaluation
- **Quantization:** Check if deployed model files (.tflite, .mlmodel, .onnx) have been quantized (FP16/INT8).
- **Execution Overhead:** Ensure local inference operations run asynchronously to prevent blocking UI main threads.
- **Hardware Integration:** Verify delegates/drivers configuration maps correctly to NPUs/Neural Engines.

### 4. Resume & Interview Impact Derivation
- Translate the evaluated architecture or code change into a highly professional, quantified resume bullet point.
- *Format:* "Architected/Designed [Feature/System] using [Technology], improving/reducing [Metric] by [Quantifiable Percentage]%."

Provide a detailed report outlining your findings and suggestions for refactoring without making code modifications.