import 'package:flutter/material.dart';
import 'package:track_your_bus/routes.dart';
import './utils/theme_color.dart';
import 'screens/auth.dart';
import 'services/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Track Your Bus',
        theme: ThemeData(
          primarySwatch: white,
        ),
        debugShowCheckedModeBanner: false,
        home: RootPage(),
      ),
    );
  }
}

