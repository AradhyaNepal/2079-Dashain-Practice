import 'package:flutter/material.dart';
import 'package:practice/screens/album_photo/main_photo_page.dart';
import 'package:practice/screens/album_photo/server_photo.dart';
import 'package:practice/screens/drop_down/backend/dropdown_provider.dart';
import 'package:practice/screens/drop_down/dropdown_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>DropDownProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:DropDownPage(),// MainPhotoPage(),
      ),
    );
  }
}
