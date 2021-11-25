import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistData {
  CollectionReference checklist = FirebaseFirestore.instance.collection('Checklist');
  late Future<DocumentSnapshot<Map<String, dynamic>>>? items;

  setChecklist(List items) async {
    try {
      await checklist.doc('r78yPLE8Z0GjOSsqjIt6').update({'checklist': items});
      print("Item updated");
    } catch (error) {
      print("Failed to update user: $error");
    }
  }

  getChecklist() {
    DocumentReference checklist = FirebaseFirestore.instance.collection('Checklist').doc('r78yPLE8Z0GjOSsqjIt6');
    return items = checklist.get() as Future<DocumentSnapshot<Map<String, dynamic>>>?;
  }
}
