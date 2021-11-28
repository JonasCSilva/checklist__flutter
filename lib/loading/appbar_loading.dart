import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/theme_model.dart';

class AppBarLoading extends StatelessWidget {
  const AppBarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              child: Shimmer.fromColors(
                  baseColor: themeNotifier.isDark ? Colors.grey[600]! : Colors.grey[400]!,
                  highlightColor: themeNotifier.isDark ? Colors.grey[500]! : Colors.grey[300]!,
                  child: Container(height: 38, width: 38, color: themeNotifier.isDark ? Colors.grey[600] : Colors.grey[400])),
              margin: const EdgeInsets.only(left: 30)),
          Expanded(
              child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text('Checked: ', style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 26))),
              Shimmer.fromColors(
                  baseColor: themeNotifier.isDark ? Colors.grey[600]! : Colors.grey[400]!,
                  highlightColor: themeNotifier.isDark ? Colors.grey[500]! : Colors.grey[300]!,
                  child: Container(height: 38, width: 54, color: themeNotifier.isDark ? Colors.grey[600] : Colors.grey[400]))
            ]),
          )),
          Container(
              child: IconButton(
                  icon: Icon(themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny, size: 34),
                  splashRadius: 30,
                  onPressed: () {
                    themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                  }),
              margin: const EdgeInsets.only(right: 20))
        ],
      );
    });
  }
}
