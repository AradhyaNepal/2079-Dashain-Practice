import 'package:flutter/material.dart';
import 'package:flutterfetch/one_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PageThree(),
      ),
    );
  }
}

