# 20. CI/CD Pipelines & Automation

- **Makefile Driven**: All common development and CI tasks (building, code generation, testing, linting) MUST be abstracted into the root `Makefile`. CI/CD pipeline YAMLs should simply call `make test-report` or `make build-apk`.
- **Pre-Commit Checks**: Code MUST NOT be merged to `main` without passing all linting (`android analyze`), formatting (`kotlin format`), and automated tests on the CI server.
- **Build Reproducibility**: CI runners MUST fetch dependencies using locked versions (`android pub get` honoring `pubspec.lock`) to ensure build reproducibility.
- **Automated Versioning**: Release pipelines MUST automatically bump the build number using tools like `cider` or fastlane before compiling production binaries.
