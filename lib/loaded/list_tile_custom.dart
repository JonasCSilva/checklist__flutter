import 'package:flutter/material.dart';
import '../checklist/checklist_model.dart';
import 'package:provider/provider.dart';

class ListTileCustom extends StatefulWidget {
  final int index;

  const ListTileCustom({Key? key, required this.index}) : super(key: key);

  @override
  State<ListTileCustom> createState() => _ListTileCustomState();
}

class _ListTileCustomState extends State<ListTileCustom> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      return ListTile(
          tileColor: checklistNotifier.items[widget.index]['checked'] ? Colors.blue : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(checklistNotifier.items[widget.index]['name'], style: const TextStyle(fontSize: 26))]),
          onLongPress: () {
            setState(() {
              checklistNotifier.items[widget.index]['checked']
                  ? checklistNotifier.items[widget.index]['checked'] = false
                  : checklistNotifier.items[widget.index]['checked'] = true;
              checklistNotifier.checklistData = checklistNotifier.items;
            });
          });
    });
  }
}
