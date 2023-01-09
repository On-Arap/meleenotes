import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melee_notes/extensions/string_extension.dart';
import 'package:melee_notes/components/add_note_dialog.dart';
import 'package:melee_notes/components/note_tile.dart';
import 'package:localstorage/localstorage.dart';

class CharPage extends StatefulWidget {
  final String char;
  final LocalStorage local;

  const CharPage({super.key, required this.char, required this.local});

  @override
  State<CharPage> createState() => _CharPageState();
}

class _CharPageState extends State<CharPage> {
  List<Map<dynamic, dynamic>> notes = [];

  List<String> docIds = [];

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getDatabaseNotes() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await firestore.collection('notes').where("char", isEqualTo: widget.char).orderBy('index').get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    docIds = querySnapshot.docs.map((doc) => doc.id).toList();

    if (allData.isNotEmpty) {
      notes = [];
      allData.forEach((data) {
        setState(() {
          notes.add(data as Map<dynamic, dynamic>);
        });
      });
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  getLocalNotes() {
    setState(() {
      var data = widget.local.getItem(widget.char) ?? [];
      if (data.isNotEmpty) {
        data.forEach((d) {
          notes.add(d);
        });
      }
    });
  }

  setLocalnotes() {
    widget.local.setItem(widget.char, notes);
  }

  void createNewNote() async {
    _titleController.text = '';
    _bodyController.text = '';

    showDialog(
        context: context,
        builder: (context) {
          return AddNoteDialog(
            titleController: _titleController,
            bodyController: _bodyController,
            onSave: saveNewTask,
            onCancel: () => Navigator.pop(context),
          );
        });
  }

  void updateNoteByIndex(index) async {
    _titleController.text = notes[index]['title'];
    _bodyController.text = notes[index]['body'];

    showDialog(
        context: context,
        builder: (context) {
          return AddNoteDialog(
            titleController: _titleController,
            bodyController: _bodyController,
            onSave: () {
              updateTask(index);
            },
            onCancel: () => Navigator.pop(context),
          );
        });
  }

  void saveNewTask() async {
    await firestore.collection('notes').add({
      'userId': "j27Sp92Tu3cTJkvtf6U17INUUm23",
      'char': widget.char,
      'title': _titleController.text,
      'body': _bodyController.text,
      'type': "none",
      'index': notes.isNotEmpty ? notes[notes.length - 1]['index'] + 1 : 0,
    }).then((value) {
      setState(() {
        notes.add({
          'userId': "j27Sp92Tu3cTJkvtf6U17INUUm23",
          'char': widget.char,
          'title': _titleController.text,
          'body': _bodyController.text,
          'type': "none",
          'index': notes.isNotEmpty ? notes[notes.length - 1]['index'] + 1 : 0,
        });
        docIds.add(value.id);
        setLocalnotes();
      });
      Navigator.pop(context);
    }).catchError((e) => print(e));
  }

  void updateTask(index) async {
    await firestore.collection('notes').doc(docIds[index]).update({'title': _titleController.text, 'body': _bodyController.text}).then(
      (value) {
        setState(() {
          notes[index]['title'] = _titleController.text;
          notes[index]['body'] = _bodyController.text;
        });
        setLocalnotes();
        Navigator.pop(context);
      },
      onError: (e) => print("Error updating document $e"),
    );
  }

  void deleteNoteByIndex(index) async {
    await firestore.collection('notes').doc(docIds[index]).delete().then(
      (doc) {
        setState(() {
          notes.remove(notes[index]);
          docIds.remove(docIds[index]);
          notes.forEach((note) {
            if (note['index'] > index) {
              note['index'] -= 1;
            }
          });
        });
        setLocalnotes();
      },
      onError: (e) => print("Error updating document $e"),
    );
  }

  @override
  void initState() {
    //getLocalNotes();
    getDatabaseNotes().then((value) {
      if (notes.isNotEmpty) {
        setLocalnotes();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.char.replaceAll('_', ' ').capitalize()),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.filter),
          )
        ],
      ),
      backgroundColor: Colors.grey[500],
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          return createNewNote();
        },
        backgroundColor: Colors.grey[700],
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Colors.grey[600],
                    color: Colors.grey[800],
                    minHeight: 3,
                  )
                : const SizedBox(height: 3),
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return NoteTile(
                      title: notes[index]['title'],
                      body: notes[index]['body'],
                      index: notes[index]['index'],
                      onSlideDelete: () {
                        deleteNoteByIndex(index);
                      },
                      onLongPressUpdate: () {
                        updateNoteByIndex(index);
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
