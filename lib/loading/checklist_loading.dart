import 'package:firstapp/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ChecklistListLoading extends StatelessWidget {
  const ChecklistListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          for (int index = 0; index < 13; index++)
            Card(
                key: Key('$index'),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  title: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    Shimmer.fromColors(
                        baseColor: themeNotifier.isDark ? Colors.grey[600]! : Colors.grey[400]!,
                        highlightColor: themeNotifier.isDark ? Colors.grey[500]! : Colors.grey[300]!,
                        child: Container(height: 34, color: themeNotifier.isDark ? Colors.grey[600] : Colors.grey[400]))
                  ]),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Shimmer.fromColors(
                          baseColor: themeNotifier.isDark ? Colors.grey[600]! : Colors.grey[400]!,
                          highlightColor: themeNotifier.isDark ? Colors.grey[500]! : Colors.grey[300]!,
                          child: Container(height: 44, width: 44, color: themeNotifier.isDark ? Colors.grey[600] : Colors.grey[400]))
                    ],
                  ),
                ))
        ],
      );
    });
  }
}
