import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'appbar_loaded.dart';
import 'checklist_loaded.dart';

class ScaffoldLoaded extends StatelessWidget {
  const ScaffoldLoaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(titleSpacing: 0, title: const AppBarLoaded()), body: const ChecklistListLoaded());
  }
}
