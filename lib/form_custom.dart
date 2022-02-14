import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'checklist/checklist_model.dart';

class FormCustom extends StatefulWidget {
  final String? name;
  final int? index;

  const FormCustom({Key? key, this.name, this.index}) : super(key: key);

  @override
  State<FormCustom> createState() => _FormCustomState();
}

class _FormCustomState extends State<FormCustom> {
  final _formKey = GlobalKey<FormState>();
  late String formName;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ChecklistModel checklistNotifier, child) {
      return Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Container(
                  width: 260,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 26)),
                    initialValue: widget.name,
                    onSaved: (val) {
                      formName = val!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  )),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    List<dynamic> items = checklistNotifier.items;
                    if (widget.name != null && widget.index != null) {
                      bool isChecked = items[widget.index!]['checked'];
                      items[widget.index!] = ({'checked': isChecked, 'name': formName});
                      checklistNotifier.checklistData = items;
                    } else {
                      items.add({'checked': false, 'name': formName});
                      checklistNotifier.checklistData = items;
                      _formKey.currentState!.reset();
                    }
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: widget.name != null ? const Text('Item Updated') : const Text('Item Added')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
