import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melee_notes/extensions/string_extension.dart';
import 'package:melee_notes/components/add_note_dialog.dart';
import 'package:melee_notes/components/note_tile.dart';
import 'package:localstorage/localstorage.dart';

import '../constants/colorsFilter.dart';

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
  final _typeController = TextEditingController();
  final ScrollController reorderScrollController = ScrollController();
  final user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getDatabaseNotes() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot querySnapshot = await firestore.collection('notes').where("userId", isEqualTo: user.uid).where("char", isEqualTo: widget.char).orderBy('index').get();
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

  setLocalnotes() async {
    await widget.local.setItem(widget.char, notes);
  }

  void createNewNote() async {
    _titleController.text = '';
    _typeController.text = 'grey';
    _bodyController.text = '';

    showDialog(
        context: context,
        builder: (context) {
          return AddNoteDialog(
            titleController: _titleController,
            typeController: _typeController,
            bodyController: _bodyController,
            onSave: saveNewTask,
            onCancel: () => Navigator.pop(context),
          );
        });
  }

  void updateNoteByIndex(index) async {
    _titleController.text = notes[index]['title'];
    _bodyController.text = notes[index]['body'];
    _typeController.text = notes[index]['type'];

    showDialog(
        context: context,
        builder: (context) {
          return AddNoteDialog(
            titleController: _titleController,
            typeController: _typeController,
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
      'userId': user.uid,
      'char': widget.char,
      'title': _titleController.text,
      'body': _bodyController.text,
      'type': _typeController.text,
      'index': notes.isNotEmpty ? notes[notes.length - 1]['index'] + 1 : 0,
    }).then((value) {
      setState(() {
        notes.add({
          'userId': user.uid,
          'char': widget.char,
          'title': _titleController.text,
          'body': _bodyController.text,
          'type': _typeController.text,
          'index': notes.isNotEmpty ? notes[notes.length - 1]['index'] + 1 : 0,
        });
        docIds.add(value.id);
        setLocalnotes();
      });
      Navigator.pop(context);
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    });
  }

  void updateTask(index) async {
    await firestore.collection('notes').doc(docIds[index]).update({'title': _titleController.text, 'body': _bodyController.text, 'type': _typeController.text}).then(
      (value) {
        setState(() {
          notes[index]['title'] = _titleController.text;
          notes[index]['body'] = _bodyController.text;
          notes[index]['type'] = _typeController.text;
        });
        setLocalnotes();
        Navigator.pop(context);
      },
      onError: (e) => print("Error updating document $e"),
    );
  }

  void reorderNote(int oldIndex, int newIndex) async {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final note = notes.removeAt(oldIndex);
      final doc = docIds.removeAt(oldIndex);
      notes.insert(newIndex, note);
      docIds.insert(newIndex, doc);

      for (var i = newIndex; i < notes.length; i++) {
        if (i > 0) {
          notes[i]['index'] = notes[i - 1]['index'] + 1;
        }
      }
    });

    for (var j = newIndex; j < notes.length; j++) {
      await firestore.collection('notes').doc(docIds[j]).update({'index': notes[j]['index']});
    }
    setLocalnotes();
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

  void handleSelectFilter(String value) {
    switch (value) {
      case '':
        break;
      case 'Settings':
        break;
    }
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

  var filterList = getColorNames();

  Widget charPage() {
    return Center(
      child: Theme(
        data: ThemeData(canvasColor: Colors.transparent),
        child: ReorderableListView(
          buildDefaultDragHandles: false,
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          header: isLoading
              ? LinearProgressIndicator(
                  backgroundColor: Colors.grey[600],
                  color: Colors.grey[800],
                  minHeight: 3,
                )
              : const SizedBox(height: 3),
          onReorder: (int oldIndex, int newIndex) {
            reorderNote(oldIndex, newIndex);
          },
          children: <Widget>[
            for (int index = 0; index < notes.length; index += 1)
              if (filterList.contains(notes[index]['type']))
                NoteTile(
                    key: Key('$index'),
                    tileIndex: index,
                    titleNote: notes[index]['title'],
                    type: notes[index]['type'],
                    body: notes[index]['body'],
                    index: notes[index]['index'],
                    onSlideDelete: () {
                      deleteNoteByIndex(index);
                    },
                    onTapUpdate: () {
                      updateNoteByIndex(index);
                    }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> listAllFilter = getColorNames();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.char.replaceAll('_', ' ').capitalize()),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(0, 50),
            elevation: 5.0,
            itemBuilder: (context) {
              return listAllFilter.map((String filter) {
                return PopupMenuItem<String>(
                  child: StatefulBuilder(
                    builder: (_context, _setState) => CheckboxListTile(
                      title: Text(
                        filter.capitalize(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: getColorByName(filter)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                      value: filterList.contains(filter),
                      activeColor: getColorByName(filter),
                      onChanged: (value) {
                        setState(() {
                          _setState(() {
                            if (!value!) {
                              filterList.remove(filter);
                            } else {
                              filterList.add(filter);
                            }
                          });
                        });
                      },
                    ),
                  ),
                );
              }).toList();
            },
          ),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1100) {
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth / 4),
              child: charPage(),
            ));
          } else {
            return charPage();
          }
        },
      ),
    );
  }
}
