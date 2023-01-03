import 'package:flutter/material.dart';
import 'package:melee_notes/extensions/string_extension.dart';

class CharPage extends StatelessWidget {
  final String char;

  const CharPage({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(char.replaceAll('_', ' ').capitalize()),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Text(char),
        ));
  }
}
