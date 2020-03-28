<p align="center"><img src="https://docs-assets.developer.apple.com/published/c104c9bff0/841b02dd-b78c-4cad-8da4-700761d34e14.png" alt="Apple Wallet logo" width="20%"></p>

# pass-flutter
A Flutter library for work with Apple Wallet passes.

## How use it

### Getting pass from URL to internal memory
```dart
import 'package:pass_flutter/pass_flutter.dart';

PassFile passFile = await Pass().getFromUrl('https://link_to_pass/pass.pkpass');
```

### Getting list of all saved passes
```dart
import 'package:pass_flutter/pass_flutter.dart';

List<PassFile> passes = await Pass().getAllSaved();
```

### Delete pass file from internal memory
```dart
import 'package:pass_flutter/pass_flutter.dart';

Pass pass = Pass();
PassFile passFile = await pass.getFromUrl('https://link_to_pass/pass.pkpass');
await pass.delete(passFile);
```

## Contribute

Please feel free to fork, improve, make pull requests or fill issues.
I'll be glad to fix bugs you encountered or improve the extension.