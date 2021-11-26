import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loading/checklist_loading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'checklist/checklist_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      return FutureBuilder<void>(
          future: Future.delayed(const Duration(seconds: 10), () => checklistNotifier.getItems()),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (checklistNotifier.items.isNotEmpty) {
              return const ChecklistList();
            } else if (snapshot.hasError) {
              return const Center(child: Text('error'));
            } else {
              return const ChecklistListLoading();
            }
          });
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
                    child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[Text(checklistNotifier.items[index]['name'], style: const TextStyle(fontSize: 26))]),
                        trailing: SizedBox(
                          width: 40,
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                  checklistNotifier.items[index]['checked']
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                  color: checklistNotifier.items[index]['checked'] ? Colors.red : null,
                                  semanticLabel: checklistNotifier.items[index]['checked'] ? 'Uncheck' : 'Check',
                                  size: 36)
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            checklistNotifier.items[index]['checked']
                                ? checklistNotifier.items[index]['checked'] = false
                                : checklistNotifier.items[index]['checked'] = true;
                            checklistNotifier.checklistData = checklistNotifier.items;
                          });
                        })))
        ],
      );
    });
  }
}
