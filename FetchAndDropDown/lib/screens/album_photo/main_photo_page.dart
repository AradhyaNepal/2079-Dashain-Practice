import 'package:flutter/material.dart';
import 'package:practice/screens/album_photo/backend/server_photo_provider.dart';
import 'package:practice/screens/album_photo/local_photo.dart';
import 'package:practice/screens/album_photo/server_photo.dart';
import 'package:provider/provider.dart';

class MainPhotoPage extends StatefulWidget {

  MainPhotoPage({Key? key}) : super(key: key);

  @override
  State<MainPhotoPage> createState() => _MainPhotoPageState();
}

class _MainPhotoPageState extends State<MainPhotoPage> {
  int currentIndex=0;
  final List<Widget> screenPageList=[
    const ServerPhoto(),
    const LocalPhoto(),
  ];

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            currentIndex=index;
            setState(() {});
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              label: "API Data",
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              label: "Local Data",
                icon: Icon(Icons.add)
            ),
          ],

        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: screenPageList[currentIndex],
        ),
      ),
    );
  }
}
