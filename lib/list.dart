import 'package:flutter/material.dart';
import 'checklist_model.dart';
import 'package:provider/provider.dart';

class MyStatefulWidget extends StatefulWidget {
  final List<dynamic> items;

  const MyStatefulWidget({Key? key, required this.items}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    widget.items.sort((a, b) {
      return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
    });

    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      /* int test = 0;
      widget.items.forEach((element) {
        if (element['checked'] == false) {
          test = test + 1;
        }
      });
      checklistNotifier.unckedCount = test; */
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          for (int index = 0; index < widget.items.length; index++)
            Card(
              key: Key('$index'),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Container(
                    child: Text(widget.items[index]['name'], style: const TextStyle(fontSize: 26)),
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                trailing: Icon(widget.items[index]['checked'] ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                    color: widget.items[index]['checked'] ? Colors.red : null,
                    semanticLabel: widget.items[index]['checked'] ? 'Uncheck' : 'Check',
                    size: 36),
                onTap: () {
                  setState(() {
                    if (widget.items[index]['checked']) {
                      widget.items[index]['checked'] = false;
                    } else {
                      widget.items[index]['checked'] = true;
                    }
                    checklistNotifier.checklistData = widget.items;
                  });
                  int test = 0;
                  widget.items.forEach((element) {
                    if (element['checked'] == false) {
                      test = test + 1;
                    }
                  });
                  checklistNotifier.unckedCount = test;
                  print(checklistNotifier.unckedCount);
                },
              ),
            ),
        ],
        /* onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = widget.items.removeAt(oldIndex);
          widget.items.insert(newIndex, item);
          checklist
              .doc('r78yPLE8Z0GjOSsqjIt6')
              .update({'checklist': widget.items})
              .then((value) => print("Item updated"))
              .catchError((error) => print("Failed to update user: $error"));
        });
      }, */
      );
    });
  }
}
