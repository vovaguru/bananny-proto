import 'package:bananny/screens/book.dart';
import 'package:bananny/screens/jigsaw_pazzle.dart';
import 'package:bananny/screens/math_quiz.dart';
import 'package:bananny/screens/scribble.dart';
import 'package:bananny/screens/yt_home.dart';
import 'package:bananny/widgets/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bananny',
      theme: ThemeData(
          //primarySwatch: Colors.yellow,
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xffffe900),
              onPrimary: Colors.black87,
              secondary: Colors.green,
              onSecondary: Colors.black,
              error: Colors.red,
              onError: Colors.pink,
              background: Colors.black,
              onBackground: Colors.black38,
              surface: Colors.black,
              onSurface: Colors.black54),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              titleTextStyle: TextStyle(fontSize: 30, color: Colors.black),
              toolbarTextStyle: TextStyle(
                  fontSize: 32, color: Colors.black, fontFamily: 'AtypText')),
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.black, dividerColor: Colors.amber),
          indicatorColor: Colors.grey,
          scaffoldBackgroundColor: const Color(0xfffef9e4),
          cardTheme: const CardTheme(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(
                  width: 2,
                  color: Colors.deepPurpleAccent, //<-- SEE HERE
                ),
              ),
              shadowColor: Color(0xfff3f3f3))),
      routes: {
        '/': (context) => const PageWrapper(),
        '/drawing': (context) => const ScribbleScreen(),
        '/yt': (context) => const YtScreen(),
        '/jspazzle': (context) => const JigsawPazzleScreen(),
        '/math': (context) => const MathQuizScreen(),
        '/book': (context) => const BookScreen(),
      },
    );
  }
}
