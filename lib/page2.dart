import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'dart:async';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _incrementCounter() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int counter = (prefs.getInt('counter') ?? 0) + 1;
      print('Pressed $counter times.');
      await prefs.setInt('counter', counter);
    }

    return Center(
        child: Column(children: [
      ElevatedButton(
        onPressed: _incrementCounter,
        child: const Text('Increment Counter'),
      ),
      const TestButton(),
    ], mainAxisAlignment: MainAxisAlignment.center));
  }
}

class TestButton extends StatelessWidget {
  const TestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference testLogs = FirebaseFirestore.instance.collection('testLogs');
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    Future<void> _addUser() async {
      // Call the user's CollectionReference to add a new user
      try {
        await testLogs.add({'operating_system': Platform.operatingSystem, 'time': DateTime.now()});
        await analytics.logEvent(name: 'testLog', parameters: {
          'operating_system': Platform.operatingSystem,
          'time': DateTime.now().toString(),
        });
        print(Platform.operatingSystem);
        print("Log Added");
      } catch (error) {
        print("Failed to add log: $error");
      }
    }

    return ElevatedButton(
      onPressed: _addUser,
      child: const Text(
        "Add testLog and Event",
      ),
    );
  }
}
