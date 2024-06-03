import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicine/home.dart';
import 'package:medicine/login.dart'; // Assuming your file is named 'login.dart'

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        // Your theme settings
      ),
      initialRoute: '/login', // Set the initial route
      routes: {
        '/login': (context) => LoginWidget(),
        '/home': (context) => HomeWidget(),
      },
    );
  }
}
