import 'package:flutter/material.dart';
import 'form_custom.dart';
import 'loaded/appbar_loaded.dart';

class SecondRoute extends StatelessWidget {
  final String? name;
  final int? index;

  const SecondRoute({Key? key, this.name, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: AppBarLoaded(
                iconButton: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 34),
                    splashRadius: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    }))),
        body: FormCustom(name: name, index: index));
  }
}
