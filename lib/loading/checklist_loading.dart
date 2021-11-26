import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../checklist/checklist_model.dart';

class ChecklistListLoading extends StatelessWidget {
  const ChecklistListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
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
                          baseColor: Colors.grey[600]!,
                          highlightColor: Colors.grey[500]!,
                          child: Container(height: 30, color: Colors.grey[600]))
                    ]),
                    trailing: SizedBox(
                      width: 40,
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Shimmer.fromColors(
                              baseColor: Colors.grey[600]!,
                              highlightColor: Colors.grey[500]!,
                              child: Container(height: 30, color: Colors.grey[600]))
                        ],
                      ),
                    )))
        ],
      );
    });
  }
}
