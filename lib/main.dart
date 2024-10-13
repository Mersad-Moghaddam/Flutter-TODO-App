import 'package:flutter/material.dart';
import 'package:flutter_todo/data/data.dart';
import 'package:flutter_todo/presentation/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

const taskBoxName = 'task';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(taskBoxName);
  runApp(const MyApp());
}

const primaryTextColor = Color(0xff1d2830);
const secondryTextColor = Color.fromARGB(255, 172, 187, 206);
const primaryColor = Color(0xff794cff);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'My To Do List',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: secondryTextColor,
            ),
            iconColor: secondryTextColor),
        colorScheme: const ColorScheme.light(
            secondary: primaryTextColor,
            onSecondary: Colors.white,
            onSurface: primaryTextColor,
            primary: primaryColor,
            surface: Color(
              0xfff3f5f8,
            )),
        useMaterial3: true,
      ),
      home: const HommeScreen(),
    );
  }
}
