import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';

import 'app.dart';

/// `main()` is the entry point of the program
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    variables: {
      "env": "main",
      "base": "https://probook-backend.staging9.com/",
    },
  );
  runApp(const MyApp());
}
