import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'appbar_loading.dart';
import 'checklist_loading.dart';

class ScaffoldLoading extends StatelessWidget {
  const ScaffoldLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const AppBarLoading(),
      ),
      body: const ChecklistListLoading(),
    );
  }
}
