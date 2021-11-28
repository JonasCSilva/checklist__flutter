import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../checklist/checklist_model.dart';
import '../route2.dart';
import 'list_tile_custom.dart';

class ChecklistListLoaded extends StatefulWidget {
  const ChecklistListLoaded({Key? key}) : super(key: key);

  @override
  State<ChecklistListLoaded> createState() => _ChecklistListLoadedState();
}

class _ChecklistListLoadedState extends State<ChecklistListLoaded> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      return ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          for (int index = 0; index < checklistNotifier.items.length; index++)
            Card(
                key: ValueKey(index),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Slidable(
                    startActionPane: ActionPane(
                      extentRatio: 0.33,
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Confirmation'),
                              content: Text('Are you sure you want to delete: ${checklistNotifier.items[index]['name']}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Don't delete"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    List<dynamic> items = checklistNotifier.items;
                                    items.removeAt(index);
                                    checklistNotifier.checklistData = items;
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      extentRatio: 0.33,
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          flex: 2,
                          onPressed: (BuildContext context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondRoute(name: checklistNotifier.items[index]['name'], index: index)),
                            );
                          },
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                      ],
                    ),
                    child: ListTileCustom(index: index)))
        ],
      );
    });
  }
}
