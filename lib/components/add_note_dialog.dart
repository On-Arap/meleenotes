import 'package:flutter/material.dart';
import 'my_add_textfield.dart';
import 'color_filter.dart';
import '../constants/colorsFilter.dart';

class AddNoteDialog extends StatefulWidget {
  final titleController;
  final typeController;
  final bodyController;

  VoidCallback onSave;
  VoidCallback onCancel;

  AddNoteDialog({
    super.key,
    required this.titleController,
    required this.typeController,
    required this.bodyController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  List<bool> selected = [];

  @override
  void initState() {
    selected = List<bool>.generate(colorList.length, (int index) {
      return colorList[index]['name'] == widget.typeController.text ? true : false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[500],
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyAddTextField(controller: widget.titleController, hintText: 'add a new title', multiline: false),
            const SizedBox(height: 10),
            MyAddTextField(controller: widget.bodyController, hintText: 'add a new body', multiline: true),
            const SizedBox(height: 10),
            ToggleButtons(
              renderBorder: false,
              constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < selected.length; i++) {
                    selected[i] = i == index;
                    if (i == index) {
                      widget.typeController.text = colorList[i]['name'];
                    }
                  }
                });
              },
              children: List<Widget>.generate(colorList.length, (int index) {
                return ColorFilter(
                  color: colorList[index]['color'],
                  isSelected: selected[index],
                );
              }),
              isSelected: selected,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: Colors.grey[900],
                  onPressed: widget.onSave,
                  child: Text('Save', style: TextStyle(color: Colors.grey[300])),
                ),
                const SizedBox(width: 5),
                MaterialButton(
                  color: Colors.grey[900],
                  onPressed: widget.onCancel,
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
