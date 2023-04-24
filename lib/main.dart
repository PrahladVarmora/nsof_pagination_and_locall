import 'package:firebase_core/firebase_core.dart';
import 'package:nstack_softech_practical/firebase_options.dart';
import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';

import 'app.dart';

/// `main()` is the entry point of the program
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
