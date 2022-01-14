import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reports/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Something wrong');
            return const Text('Error');
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
