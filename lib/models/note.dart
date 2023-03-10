const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, title, description, time];
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime? createdTime;
  const Note({
    this.id,
    required this.title,
    this.createdTime,
    required this.description,
  });

  Note copy(
          {int? id,
          String? title,
          String? description,
          DateTime? createdTime}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
        description: description ?? this.description,
      );
  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
        description: json[NoteFields.description] as String,
      );
  Map<String, Object?> tojson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime?.toIso8601String(),
      };
}
