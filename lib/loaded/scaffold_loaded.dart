import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../route2.dart';
import 'appbar_loaded.dart';
import 'checklist_loaded.dart';

class ScaffoldLoaded extends StatelessWidget {
  const ScaffoldLoaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0,
            title: AppBarLoaded(
                iconButton: IconButton(
                    icon: const Icon(Icons.add, size: 34),
                    splashRadius: 30,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SecondRoute()),
                      );
                    }))),
        body: const ChecklistListLoaded());
  }
}
