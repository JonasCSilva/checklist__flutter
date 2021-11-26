import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../checklist/checklist_model.dart';
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
        children: <Widget>[
          for (int index = 0; index < checklistNotifier.items.length; index++)
            Card(
                key: ValueKey(index),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Slidable(
                    startActionPane: const ActionPane(
                      extentRatio: 0.33,
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    endActionPane: const ActionPane(
                      extentRatio: 0.33,
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          flex: 2,
                          onPressed: null,
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
