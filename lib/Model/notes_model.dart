import 'package:hive/hive.dart';
part 'notes_model.g.dart';


@HiveType(typeId: 0)
class NotesModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? image;

  NotesModel({
    required this.name,
    required this.email,
    required this.image,
  });
}
