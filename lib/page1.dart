import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'checklist_model.dart';
import 'list.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1 createState() => _Page1();
}

class _Page1 extends State<Page1> {
  late List<Map<String, dynamic>>? docs;
  late Future<DocumentSnapshot<Map<String, dynamic>>> myFuture2;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: checklistNotifier.items,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          /* if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Text("Document does not exist");
        } */

          if (snapshot.connectionState == ConnectionState.done) {
            return MyStatefulWidget(items: snapshot.data!['checklist']);
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    });
  }
}
