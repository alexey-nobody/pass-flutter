<p align="center"><img src="https://docs-assets.developer.apple.com/published/c104c9bff0/841b02dd-b78c-4cad-8da4-700761d34e14.png" alt="Apple Wallet logo" width="20%"></p>

![Flutter GitHub Actions](https://github.com/alexeynobody/pass-flutter/workflows/Flutter%20GitHub%20Actions/badge.svg)
[![Pub Package](https://img.shields.io/pub/v/pass_flutter.svg)](https://pub.dartlang.org/packages/pass_flutter)

# pass-flutter
A Flutter library for work with Apple Wallet passes.

## How use it

### Getting pass from URL to internal memory
```dart
import 'package:pass_flutter/pass_flutter.dart';

PassFile passFile = await Pass().saveFromUrl(url: 'https://link_to_pass/pass.pkpass');
```

### Getting list of all saved passes
```dart
import 'package:pass_flutter/pass_flutter.dart';

List<PassFile> passes = await Pass().getAllSaved();
```

### Fetch preview from url and save it
```dart
import 'package:pass_flutter/pass_flutter.dart';

PassFile passFile = await Pass().fetchPreviewFromUrl(url: 'https://link_to_pass/pass.pkpass');
passFile.save();
```

or delete it
```dart
import 'package:pass_flutter/pass_flutter.dart';

PassFile passFile = await Pass().fetchPreviewFromUrl(url: 'https://link_to_pass/pass.pkpass');
passFile.delete();
```

### Delete pass file from internal memory
```dart
import 'package:pass_flutter/pass_flutter.dart';

Pass pass = Pass();
PassFile passFile = await pass.saveFromUrl(url: 'https://link_to_pass/pass.pkpass');
await pass.delete(passFile);
```

OR

```dart
passFile.delete();
```

## Contribute

Please feel free to fork, improve, make pull requests or fill issues.
I'll be glad to fix bugs you encountered or improve the extension.

## Changelog

Refer to the [Changelog](https://github.com/alexeynobody/pass-flutter/blob/master/CHANGELOG.md) to get all release notes.