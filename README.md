## CRUD-TO-DO-APP-FROG

# Install all dependencies before run project

> Install mason

```bash
dart pub global activate mason_cli
```

> Add very_good_dart

```bash
mason add -g very_good_dart_package
```

> Upgrade pub version

```bash
dart pub get
```

# Follow the Frog documement

_Link doc_
https://dartfrog.vgv.dev/docs/tutorials/todos

# Export dart path

```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

# Generate models

_NOTE: cd to specific package_

```bash
dart run build_runner build --delete-conflicting-outputs
```

# Create packages

```bash
mason make very_good_dart_package --project_name "new_package" --description "my_description" -o packages
```

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An example application built with dart_frog

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
