import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/loaded/scaffold_loaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'loading/scaffold_loading.dart';
import 'theme/theme_model.dart';
import 'checklist/checklist_model.dart';
import 'theme/theme_preference.dart';

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
              home: FutureBuilder<void>(
                  future: Future.delayed(const Duration(seconds: 10), () => checklistNotifier.getItems()),
                  builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (checklistNotifier.items.isNotEmpty) {
                      return const ScaffoldLoaded();
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    } else {
                      return const ScaffoldLoading();
                    }
                  }));
        }));
  }
}
