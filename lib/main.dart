import 'package:cardgame/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import 'New Game.dart';
import 'Question.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login Screen with Firebase Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      initialRoute: '/Start',
      getPages: [
       // GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/Start', page: () => HomeScreen()),
        GetPage(name: '/new-game', page: () => GameScreen()),
       // GetPage(name: '/question', page: () => QuestionScreen(question: null,)),
      ],
    );
  }
}

class LoginPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {


    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offAll(() => HomeScreen());
      }
    });
    return FlutterLogin(
      title: 'My App',
      onLogin: (data) => _loginUser(data),
      onSignup: (data) => _registerUser(data),
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.blue,
        pageColorLight: Colors.white,
        pageColorDark: Colors.white,
        accentColor: Colors.blue,
        titleStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
        bodyStyle: TextStyle(
          color: Colors.white,
        ),
        textFieldStyle: TextStyle(
          color: Colors.black,
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        cardTheme: CardTheme(
          color: Colors.blue,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Future<String?> _loginUser(LoginData data) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return _navigateToHomeScreen();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> _registerUser(SignupData data) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      return _navigateToHomeScreen();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: name);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  String? _navigateToHomeScreen() {
    Get.offAll(() => HomeScreen());
    return null;
  }
}