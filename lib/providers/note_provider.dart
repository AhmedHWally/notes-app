import 'package:flutter/material.dart';
import '../models/note.dart';
import '../dbHelper/notes_database.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes {
    return [..._notes];
  }

  Future<void> addNote(String title, String noteData) async {
    final newNote =
        Note(description: noteData, title: title, createdTime: DateTime.now());

    final db = await NotesDatabase.instance.create(newNote);
    _notes.add(db);

    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final dataList = await NotesDatabase.instance.readAllNotes();
    _notes = dataList;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await NotesDatabase.instance.delete(id);
    _notes.removeWhere(
      (note) {
        return note.id == id;
      },
    );

    notifyListeners();
  }

  Future<void> update(Note note) async {
    await NotesDatabase.instance.update(note);
    final noteIndex = _notes.indexWhere((item) => item.id == note.id);
    _notes[noteIndex] = note;

    notifyListeners();
  }
}
