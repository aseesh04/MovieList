import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movielist/login.dart';
import 'package:movielist/model/database1.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielist/pages/page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movielist/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Database1>('transactions');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Movie List App';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: TransactionPage(),
      );
}

// class HomeScreen extends StatelessWidget {
//   final auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FlatButton(
//           child: Text('Logout'),
//           onPressed: () {
//             auth.signOut();
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => LoginScreen()));
//           },
//         ),
//       ),
//     );
//   }
// }
