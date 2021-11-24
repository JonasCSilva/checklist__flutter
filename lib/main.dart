import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Initialization());
}

class Initialization extends StatefulWidget {
  const Initialization({Key? key}) : super(key: key);

  @override
  _Initialization createState() => _Initialization();
}

class _Initialization extends State<Initialization> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: SelectableText('Error'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const App();
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
