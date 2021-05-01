import 'package:e_commerceapp/app/landing_page.dart';
import 'package:e_commerceapp/models/cart.dart';
import 'package:e_commerceapp/services/auth.dart';
import 'package:e_commerceapp/services/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Colors.blue[700],
        ),
        home: LandingPage(),
      ),
    );
  }
}
