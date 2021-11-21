import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Page1 extends StatefulWidget {
  final Future<QuerySnapshot> myFuture;

  const Page1({Key? key, required this.myFuture}) : super(key: key);

  @override
  _Page1 createState() => _Page1();
}

class _Page1 extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: widget.myFuture,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List<DocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data!.docs.toList() as List<DocumentSnapshot<Map<String, dynamic>>>;
          return ListView.builder(
              /* padding: const EdgeInsets.all(8), */
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Center(child: Text(docs[index].data()!['index'].toString())),
                );
              });
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
