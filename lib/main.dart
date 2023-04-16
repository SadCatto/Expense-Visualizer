import 'package:expense_tracker/screens/analytics_screen.dart';
import 'package:expense_tracker/screens/expense_screen.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/screens/sign_up.dart';
import 'package:expense_tracker/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    String startRoute;
    if (firebaseUser != null) {
      startRoute = "/home";
    } else {
      startRoute = "/login";
    }
    return MaterialApp(
        initialRoute: startRoute,
        routes: {
          '/home':(context) => const HomeScreen(),
          '/signup' : (context) => SignUp(),
          '/expense' : (context) => const ExpenseScreen(),
          '/login' : (context) => const LoginScreen(),
          '/analytics' : (context) => const AnalyticsScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          primaryColor: primary,
        ),
        // home: SignUp()
    );
  }
}

