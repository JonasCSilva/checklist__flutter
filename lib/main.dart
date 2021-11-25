import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'theme_model.dart';
import 'checklist_model.dart';
import 'main_page.dart';
import 'theme_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<dynamic> futures = await Future.wait([ThemePreference.getThemePreference(), Firebase.initializeApp()]);
  runApp(App(initialIsDark: futures[0]));
}

class App extends StatelessWidget {
  final bool initialIsDark;

  const App({Key? key, required this.initialIsDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeModel(initialIsDark)),
          ChangeNotifierProvider(create: (_) => ChecklistModel()),
        ],
        child: Consumer2(builder: (context, ThemeModel themeNotifier, ChecklistModel checklistNotifier, child) {
          return MaterialApp(
              title: 'Checklist',
              theme: themeNotifier.isDark ? ThemeData(brightness: Brightness.dark) : ThemeData(brightness: Brightness.light),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: Text('Unchecked: ' + checklistNotifier.checkedCount.toString() + '/' + checklistNotifier.totalCount.toString()),
                    actions: [
                      Container(
                          child: IconButton(
                              icon: Icon(themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny, size: 34),
                              splashRadius: 30,
                              onPressed: () {
                                themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                              }),
                          margin: const EdgeInsets.only(right: 20))
                    ]),
                body: MainPage(),
              ));
        }));
  }
}
