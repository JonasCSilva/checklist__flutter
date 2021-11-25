import 'package:flutter/material.dart';
import 'checklist_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistModel extends ChangeNotifier {
  late ChecklistFirebase _checklistFirebase;
  late Future<DocumentSnapshot<dynamic>> items;
  late List<dynamic> items3;
  int _checkedCount = 0;
  int _totalCount = 0;

  int get checkedCount => _checkedCount;

  int get totalCount => _totalCount;

  ChecklistModel() {
    _checklistFirebase = ChecklistFirebase();
  }

  set checklistData(List items) {
    _checklistFirebase.setChecklist(items);
    updateValues(items);
  }

  Future<List<dynamic>> getItems() async {
    items3 = await _checklistFirebase.getItems();
    updateValues(items3);
    items3.sort((a, b) {
      return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
    });
    return items3;
  }

  void updateValues(items) {
    _checkedCount = count(items)['counterChecked'] as int;
    _totalCount = count(items)['counterTotal'] as int;
    notifyListeners();
  }

  Map<String, int> count(List items) {
    int counterChecked = 0;
    int counterTotal = 0;
    for (var item in items) {
      if (item['checked'] == true) {
        counterChecked++;
      }
      counterTotal++;
    }
    return {'counterChecked': counterChecked, 'counterTotal': counterTotal};
  }
}
