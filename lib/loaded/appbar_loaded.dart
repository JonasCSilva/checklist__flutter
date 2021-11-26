import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../theme/theme_model.dart';
import '../checklist/checklist_model.dart';

class AppBarLoaded extends StatelessWidget {
  const AppBarLoaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (context, ThemeModel themeNotifier, ChecklistModel checklistNotifier, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              child: IconButton(
                  icon: const Icon(Icons.add, size: 34),
                  splashRadius: 30,
                  onPressed: () {
                    print('');
                  }),
              margin: const EdgeInsets.only(left: 20)),
          Expanded(
            child: Center(
                child: Text.rich(
                    TextSpan(text: 'Checked: ', style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 26)), children: <InlineSpan>[
              TextSpan(
                  text: checklistNotifier.checkedCount.toString() + '/' + checklistNotifier.totalCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600))
            ]))),
          ),
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
