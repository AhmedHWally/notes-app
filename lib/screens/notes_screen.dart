import 'package:flutter/material.dart';

import 'package:last_note_app/widgets/note_body.dart';
import './add_note_screen.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import 'note_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});
  static const routeName = "/note-screen";

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<NoteProvider>(context, listen: false).fetchAndSetData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NoteProvider>(context);
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              dropdownColor: Colors.white54,
              items: const [
                DropdownMenuItem(
                  value: "ar",
                  child: Text("ar"),
                ),
                DropdownMenuItem(
                  value: "en",
                  child: Text("en"),
                )
              ],
              onChanged: (value) {
                if (value == "en") {
                  provider.setLocale(const Locale('en'));
                }
                if (value == "ar") {
                  provider.setLocale(const Locale('ar'));
                }
              },
            )),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddNote.routeName);
                },
                icon: const Icon(Icons.add))
          ],
          title: Text(
            AppLocalizations.of(context)!.homepagetitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          foregroundColor: Colors.white,
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
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : notes.notes.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.zeronotes,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                  blurRadius: 1,
                                  offset: Offset(2, 2),
                                  color: Colors.black)
                            ]),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 220,
                      ),
                      itemBuilder: (ctx, i) => Notebody(notes.notes[i]),
                      itemCount: notes.notes.length,
                    ),
        ]));
  }
}
