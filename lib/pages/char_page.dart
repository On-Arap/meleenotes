import 'package:flutter/material.dart';
import 'package:melee_notes/extensions/string_extension.dart';

import 'package:melee_notes/components/add_note_dialog.dart';

class CharPage extends StatefulWidget {
  final String char;

  const CharPage({super.key, required this.char});

  @override
  State<CharPage> createState() => _CharPageState();
}

class _CharPageState extends State<CharPage> {
  void createNewNote() async {
    showDialog(
        context: context,
        builder: (context) {
          return AddNoteDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.char.replaceAll('_', ' ').capitalize()),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return createNewNote();
        },
        backgroundColor: Colors.grey[900],
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text(widget.char),
      ),
    );
  }
}
