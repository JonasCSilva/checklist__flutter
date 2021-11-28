import 'package:flutter/material.dart';
import 'checklist_firebase.dart';

class ChecklistModel extends ChangeNotifier {
  late ChecklistFirebase _checklistFirebase;
  List<dynamic> _items = [];
  int _checkedCount = 0;
  int _totalCount = 0;

  int get checkedCount => _checkedCount;

  int get totalCount => _totalCount;

  List<dynamic> get items => _items;

  ChecklistModel() {
    _checklistFirebase = ChecklistFirebase();
  }

  set checklistData(List items) {
    _checklistFirebase.setChecklist(items);
    updateValues(items);
  }

  Future<void> getItems() async {
    var temp = await _checklistFirebase.getItems();
    updateValues(temp);
  }

  void updateValues(items) {
    _checkedCount = count(items)['counterChecked'] as int;
    _totalCount = count(items)['counterTotal'] as int;
    _items = items;
    _items.sort((a, b) {
      return a['name'].toLowerCase().compareTo(b['name'].toLowerCase());
    });
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
