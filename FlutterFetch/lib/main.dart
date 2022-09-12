import 'package:flutter/material.dart';
import 'package:flutterfetch/ProjectManager.dart';
import 'package:flutterfetch/one_provider.dart';
import 'package:flutterfetch/page_four.dart';
import 'package:flutterfetch/page_one.dart';
import 'package:flutterfetch/page_three.dart';
import 'package:flutterfetch/two_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>OneProvider()),
        ChangeNotifierProvider(create: (context)=>TwoProvider()),
        ChangeNotifierProvider(create: (context)=>ProjectManager()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme.light().copyWith(primary:Colors.red,secondary: Colors.red),

          primarySwatch: Colors.blue,
        ),
        home: const EcoHot(),
      ),
    );
  }
}

