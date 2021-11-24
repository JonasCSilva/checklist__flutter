import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'theme_model.dart';
import 'page1.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            title: 'Checklist',
            theme: themeNotifier.isDark ? ThemeData(brightness: Brightness.dark) : ThemeData(brightness: Brightness.light),
            debugShowCheckedModeBanner: false,
            home: const NavigationPages(),
          );
        }));
  }
}

class NavigationPages extends StatefulWidget {
  const NavigationPages({Key? key}) : super(key: key);

  @override
  _NavigationPages createState() => _NavigationPages();
}

class _NavigationPages extends State<NavigationPages> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> myFuture;

  Offset position = const Offset(20.0, 20.0);

  @override
  void initState() {
    super.initState();
    DocumentReference checklist = FirebaseFirestore.instance.collection('Checklist').doc('r78yPLE8Z0GjOSsqjIt6');
    myFuture = checklist.get() as Future<DocumentSnapshot<Map<String, dynamic>>>;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return ChangeNotifierProvider(
          create: (_) => ThemeModel(),
          child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
            return Scaffold(
              appBar: AppBar(centerTitle: true, title: Text('0'), actions: [
                SizedBox(
                    height: 75.0,
                    width: 75.0,
                    child: IconButton(
                        icon: Icon(themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny, size: 36),
                        onPressed: () {
                          themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                        }))
              ]),
              body: Stack(children: <Widget>[Page1(myFuture: myFuture)]),
            );
          }));
    });
  }
}
