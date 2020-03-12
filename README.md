<img src="https://docs-assets.developer.apple.com/published/c104c9bff0/841b02dd-b78c-4cad-8da4-700761d34e14.png" alt="Apple Wallet logo" width="216" height="216" align="left">

# pass-flutter

<p align="center">A Flutter library for work with Apple Wallet passes.</p>

<br><br><br><br><br><br><br>

# How use it

## Getting pass from URL
```dart
import 'package:pass_flutter/pass_flutter.dart';

PassFile passes = await new Pass().getFromUrl('https://link_to_passes/pass.pkpass');
```

## Getting list of all saved passes
```dart
import 'package:pass_flutter/pass_flutter.dart';

List<PassFile> passes = await new Pass().getAllSaved();
```
