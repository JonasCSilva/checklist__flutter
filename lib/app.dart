import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page2.dart';
import 'page1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'theme_model.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            title: 'Startup Name Generator',
            theme: themeNotifier.isDark
                ? ThemeData(brightness: Brightness.dark, tabBarTheme: const TabBarTheme(labelColor: Colors.white))
                : ThemeData(brightness: Brightness.light, tabBarTheme: const TabBarTheme(labelColor: Colors.black)),
            debugShowCheckedModeBanner: false,
            home: const NavigationPages(),
          );
        }));
  }
}

const List<Tab> tabs = <Tab>[
  Tab(icon: Icon(Icons.person)),
  Tab(icon: Icon(Icons.email)),
];

class NavigationPages extends StatefulWidget {
  const NavigationPages({Key? key}) : super(key: key);

  @override
  _NavigationPages createState() => _NavigationPages();
}

class _NavigationPages extends State<NavigationPages> with /* Single */ TickerProviderStateMixin {
  late Future<QuerySnapshot> myFuture;

  late TabController _tabController;
  int _selectedIndex = 0;
  late List<Widget> tabWidgets;

  @override
  void initState() {
    super.initState();
    CollectionReference dishes = FirebaseFirestore.instance.collection('dishes');
    myFuture = dishes.get();
    tabWidgets = <Widget>[
      Page1(myFuture: myFuture),
      const Page2(),
    ];
    _tabController = TabController(initialIndex: 0, vsync: this, length: tabWidgets.length);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(_selectedIndex.toString()),
            actions: [
              IconButton(
                  icon: Icon(themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny),
                  onPressed: () {
                    themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                  })
            ],
          ),
          bottomNavigationBar: Material(
              child: TabBar(
                controller: _tabController,
                tabs: tabs,
              ),
              color: themeNotifier.isDark ? Theme.of(context).bottomAppBarColor : Colors.blue),
          body: TabBarView(
            controller: _tabController,
            children: tabWidgets,
          ));
    });
  }
}
