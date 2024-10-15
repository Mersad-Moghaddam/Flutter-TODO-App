import 'package:flutter/material.dart';
import 'package:flutter_todo/data/entity/data.dart';
import 'package:flutter_todo/data/repository/repository.dart';
import 'package:flutter_todo/data/source/hive_task_source.dart';
import 'package:flutter_todo/view/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

const taskBoxName = 'task';

/// Main entry point for the app.
///
/// 1. Initializes Hive
/// 2. Registers the [TaskEntity] and [Priority] adapters
/// 3. Opens the box for storing tasks
/// 4. Runs the app with the [Repository] as the data source provider
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  runApp(ChangeNotifierProvider<Repository<TaskEntity>>(
      create: (context) => Repository<TaskEntity>(
          localDataSource: HiveTaskSource(box: Hive.box(taskBoxName))),
      child: const MyApp()));
}

const primaryTextColor = Color(0xff1d2830);
const secondryTextColor = Color.fromARGB(255, 172, 187, 206);
const primaryColor = Color(0xff794cff);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override

  /// The build method for the [MaterialApp].
  ///
  /// This method returns a [MaterialApp] widget with the following properties:
  ///
  /// * [debugShowCheckedModeBanner] is set to false to hide the debug banner
  /// * [debugShowMaterialGrid] is set to false to hide the Material grid
  /// * [title] is set to 'My To Do List'
  /// * [theme] is set to a [ThemeData] object with the following properties:
  ///   - [textTheme] is set to the [Poppins] font
  ///   - [inputDecorationTheme] is set to a [InputDecorationTheme] object with
  ///     [labelStyle] and [iconColor] set to [secondryTextColor]
  ///   - [colorScheme] is set to a [ColorScheme] object with the following
  ///     properties:
  ///     - [secondary] is set to [primaryTextColor]
  ///     - [onSecondary] is set to [Colors.white]
  ///     - [onSurface] is set to [primaryTextColor]
  ///     - [primary] is set to [primaryColor]
  ///     - [surface] is set to [Color(0xfff3f5f8)]
  ///   - [useMaterial3] is set to true to use the Material 3 design
  /// * [home] is set to a [HommeScreen] widget
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
