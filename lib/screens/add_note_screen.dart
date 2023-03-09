import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});
  static const routeName = "/add-note-screen";
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var _isInit = true;
  bool isUpdate = false;
  Note _editedNote = const Note(id: null, title: '', description: '');
  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        _editedNote = ModalRoute.of(context)?.settings.arguments as Note;
        isUpdate = true;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();
  String? title;
  String? note;
  Future<void> addNote() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_editedNote.id != null) {
      final newNote = _editedNote.copy(
          title: title, description: note, createdTime: DateTime.now());
      await Provider.of<NoteProvider>(context, listen: false).update(newNote);
    } else {
      await Provider.of<NoteProvider>(context, listen: false)
          .addNote(title!, note!);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                addNote();
              },
              icon: _editedNote.id != null
                  ? const Icon(Icons.edit, color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
                          blurRadius: 1)
                    ])
                  : const Icon(Icons.add, color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(2, 2),
                          blurRadius: 1)
                    ]))
        ],
        title: Text(
          isUpdate
              ? AppLocalizations.of(context)!.updatenote
              : AppLocalizations.of(context)!.addnote,
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
      body: Container(
        color: Colors.black87,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    initialValue: "${_editedNote.title} ",
                    validator: (value) {
                      if (value?.trim() == "" || value == null) {
                        return AppLocalizations.of(context)!
                            .addnotetitleerrorlabel;
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      title = value;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                  blurRadius: 1)
                            ]),
                        label: Text(
                            AppLocalizations.of(context)!.addnotetitlelabel),
                        filled: true,
                        fillColor: Colors.grey[800],
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: "${_editedNote.description} ",
                    validator: (value) {
                      if (value?.trim() == "" || value == null) {
                        return AppLocalizations.of(context)!
                            .addnotedescriptionerrorlabel;
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      note = value.replaceAll("\n", " ");
                    },
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                  blurRadius: 1)
                            ]),
                        label: Text(AppLocalizations.of(context)!
                            .addnotedescriptionlabel),
                        filled: true,
                        fillColor: Colors.grey[800],
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2.0),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    maxLines: 6,
                    textInputAction: TextInputAction.newline,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      addNote();
                    },
                    label: _editedNote.id != null
                        ? const Icon(
                            Icons.edit,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 2)
                            ],
                          )
                        : const Icon(
                            Icons.add,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 2)
                            ],
                          ),
                    icon: _editedNote.id != null
                        ? Text(
                            AppLocalizations.of(context)!.updatenotebuttonlabel,
                            style: const TextStyle(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 2)
                              ],
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.addnotebuttonlabel,
                            style: const TextStyle(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 2)
                              ],
                            ),
                          ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey),
                        elevation: MaterialStateProperty.all(0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  )
                ]),
              ),
            ),
          )),
        ]),
      ),
    );
  }
}
