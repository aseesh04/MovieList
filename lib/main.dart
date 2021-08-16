import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movielist/login.dart';
import 'package:movielist/model/database1.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielist/pages/page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movielist/app.dart';

void main() async {
  MaterialApp(
    debugShowCheckedModeBanner: false,
  );
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());

  await Hive.openBox<Database1>('transactions');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Hive.initFlutter();

//   Hive.registerAdapter(TransactionAdapter());
//   await Hive.openBox<Database1>('transactions');

 

// class MyApp extends StatelessWidget {
//   static final String title = 'Movie List App';

//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: title,
//         theme: ThemeData(primarySwatch: Colors.indigo),
//         home: TransactionPage(),
//       );
// }
