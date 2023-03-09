import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key});
  static const routeName = "/note-details-screen";

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  var _isInit = true;
  Note _editedNote = const Note(title: '', description: '');
  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        _editedNote = ModalRoute.of(context)?.settings.arguments as Note;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editedNote.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 1)
              ]),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black87,
        ),
        SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _editedNote.description,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
                          blurRadius: 1)
                    ]),
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
