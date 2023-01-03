import 'package:flutter/material.dart';
import 'package:melee_notes/components/my_button.dart';

import 'my_add_textfield.dart';
import 'my_textfield.dart';

class AddNoteDialog extends StatelessWidget {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  AddNoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[500],
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyAddTextField(controller: titleController, hintText: 'add a new title', multiline: false),
            const SizedBox(height: 10),
            MyAddTextField(controller: bodyController, hintText: 'add a new body', multiline: true),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    print(titleController.text);
                    print(bodyController.text);
                  },
                  child: Text('Save', style: TextStyle(color: Colors.grey[300])),
                  color: Colors.grey[900],
                ),
                const SizedBox(width: 5),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.grey[300])),
                  color: Colors.grey[900],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
