import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../screens/add_note_screen.dart';
import '../screens/note_details_screen.dart';

class Notebody extends StatefulWidget {
  final Note note;
  const Notebody(this.note);

  @override
  State<Notebody> createState() => _Notebody();
}

class _Notebody extends State<Notebody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey[800]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 28,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 2, left: 2),
                child: Text(
                  (widget.note.title),
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 1)
                      ]),
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(NoteDetailsScreen.routeName,
                        arguments: widget.note);
                  },
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.note.description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.language == "English"
                            ? DateFormat.yMMMd()
                                .format(widget.note.createdTime!)
                            : DateFormat.yMMMd('ar')
                                .format(widget.note.createdTime!),
                        style: const TextStyle(color: Colors.yellow, shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 1)
                        ]),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: Text(
                                        AppLocalizations.of(context)!
                                            .alearttitle,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    content: Text(
                                        AppLocalizations.of(context)!
                                            .aleartdescription,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await Provider.of<NoteProvider>(
                                                    context,
                                                    listen: false)
                                                .delete(widget.note.id!);
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .aleartbuttondelete,
                                              style: const TextStyle(
                                                  color: Colors.white))),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .aleartbuttonkeep,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ))
                                    ],
                                  ));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddNote.routeName,
                              arguments: widget.note);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.yellow,
                        )),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
