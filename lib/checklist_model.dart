import 'package:flutter/material.dart';
import 'checklist_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChecklistModel extends ChangeNotifier {
  late ChecklistData _checklistData;
  late Future<DocumentSnapshot<Map<String, dynamic>>>? items;
  int _unckedCount = 0;

  int get unckedCount => _unckedCount;

  set unckedCount(int newValue) {
    _unckedCount = newValue;
    /* notifyListeners(); */
  }

  ChecklistModel() {
    _checklistData = ChecklistData();
    getData();
  }

  set checklistData(List items) {
    _checklistData.setChecklist(items);
  }

  getData() async {
    items = _checklistData.getChecklist();
    notifyListeners();
  }
}
