import 'package:flutter/material.dart';
import 'my_add_textfield.dart';

class AddNoteDialog extends StatelessWidget {
  final titleController;
  final bodyController;

  VoidCallback onSave;
  VoidCallback onCancel;

  AddNoteDialog({
    super.key,
    required this.titleController,
    required this.bodyController,
    required this.onSave,
    required this.onCancel,
  });

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
                  color: Colors.grey[900],
                  onPressed: onSave,
                  child: Text('Save', style: TextStyle(color: Colors.grey[300])),
                ),
                const SizedBox(width: 5),
                MaterialButton(
                  color: Colors.grey[900],
                  onPressed: onCancel,
                  child: Text('Cancel', style: TextStyle(color: Colors.grey[300])),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
