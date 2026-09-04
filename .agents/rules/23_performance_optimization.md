# 23. Performance & Optimization

- **Const Constructors**: Maximize the use of `const` constructors for all static UI elements to reduce widget rebuild overhead and garbage collection.
- **Efficient Lists**: Use `ListView.builder` or `SliverList` for rendering dynamic data arrays to ensure lazy loading. Never use a standard `ListView` or `Column` for large datasets.
- **Minimize Rebuilds**: Ensure `BlocBuilder` is scoped as tightly as possible around the exact widgets that need to change. Avoid wrapping the entire `Scaffold` in a builder if only a single text field changes.
- **Image Optimization**: Ensure network and local images are cached properly (e.g., using `cached_network_image`) and sized appropriately to avoid massive raster cache memory spikes.
