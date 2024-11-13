import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/Model/notes_model.dart';
import 'package:hive_crud/auth_page/splace_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {

   await Hive.initFlutter();
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('Notes');
  runApp(const MyApp());


}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplaceScreen(),
    );
  }
}
