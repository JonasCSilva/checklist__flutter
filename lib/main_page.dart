import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'checklist_model.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final placeholderList = [
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
    {'checked': false, 'name': 'loadingPlaceholder'},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      return FutureProvider<List<dynamic>?>(
          initialData: placeholderList, create: (context) => checklistNotifier.getItems(), child: const ChecklistList());
    });
  }
}

class ChecklistList extends StatefulWidget {
  const ChecklistList({Key? key}) : super(key: key);

  @override
  State<ChecklistList> createState() => _ChecklistListState();
}

class _ChecklistListState extends State<ChecklistList> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> items = context.watch<List<dynamic>>();
    bool isLoading = items[12]['name'] == 'loadingPlaceholder' ? true : false;

    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      return ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          for (int index = 0; index < items.length; index++)
            Card(
                key: Key('$index'),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    title: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      Shimmer.fromColors(
                          baseColor: isLoading ? Colors.grey[600]! : Theme.of(context).textTheme.bodyText2!.color!,
                          highlightColor: isLoading ? Colors.grey[500]! : Theme.of(context).primaryTextTheme.bodyText2!.color!,
                          enabled: isLoading,
                          child: isLoading
                              ? Container(height: 30, color: Colors.grey[600])
                              : Text(items[index]['name'], style: const TextStyle(fontSize: 26)))
                    ]),
                    trailing: Container(
                      width: 40,
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Shimmer.fromColors(
                              baseColor: isLoading ? Colors.grey[600]! : (items[index]['checked'] ? Colors.red : Colors.black),
                              highlightColor: isLoading ? Colors.grey[500]! : Colors.transparent,
                              enabled: isLoading,
                              child: isLoading
                                  ? Container(height: 30, color: Colors.grey[600])
                                  : Icon(items[index]['checked'] ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                                      color: items[index]['checked'] ? Colors.red : null,
                                      semanticLabel: items[index]['checked'] ? 'Uncheck' : 'Check',
                                      size: 36))
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        items[index]['checked'] ? items[index]['checked'] = false : items[index]['checked'] = true;
                        checklistNotifier.checklistData = items;
                      });
                    }))
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
