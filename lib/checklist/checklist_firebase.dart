import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistFirebase {
  DocumentReference checklist = FirebaseFirestore.instance.collection('users').doc('PUWNgT8cw9VPlJBc8GjKhIJoID63');

  void setChecklist(List items) async {
    try {
      await checklist.update({'checklist': items});
      print("Item updated");
    } catch (error) {
      print("Failed to update user: $error");
    }
  }

  Future<DocumentSnapshot<dynamic>>? getChecklist() async {
    return await checklist.get();
  }

  Future<List<dynamic>> getItems() async {
    DocumentSnapshot<dynamic> items2 = await checklist.get();
    return items2.data()!['checklist'];
  }
}
