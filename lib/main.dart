import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_note_app/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/notes_screen.dart';
import './screens/add_note_screen.dart';
import './providers/note_provider.dart';
import './l10n/l10n.dart';
import './screens/note_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LocaleProvider()),
        ChangeNotifierProvider(create: (ctx) => NoteProvider())
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, locale, _) => FutureBuilder(
          future: locale.getLocale,
          builder: (context, snapshot) => MaterialApp(
              supportedLocales: L10n.all,
              locale: snapshot.data,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              routes: {
                AddNote.routeName: (context) => const AddNote(),
                NotesScreen.routeName: (context) => const NotesScreen(),
                NoteDetailsScreen.routeName: (context) =>
                    const NoteDetailsScreen()
              },
              debugShowCheckedModeBanner: false,
              home: const NotesScreen()),
        ),
      ),
    );
  }
}
