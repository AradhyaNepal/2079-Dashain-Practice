import 'package:flutter/material.dart';
import 'package:flutterfetch/ContactPage.dart';
import 'package:flutterfetch/ProjectPage.dart';
import 'package:flutterfetch/homePage.dart';

class EcoHot extends StatefulWidget {
  const EcoHot({Key? key}) : super(key: key);

  @override
  State<EcoHot> createState() => _EcoHotState();
}

class _EcoHotState extends State<EcoHot> {
  List<Widget> pagesList=[
    ProjectPage(),
    ContactPage(),
  ];
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pagesList[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: currentPage,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey.withOpacity(0.6),
          selectedFontSize: 11,
          unselectedFontSize: 11,

          onTap: (selectedPage) {

            setState(() {
              currentPage=selectedPage;
            });


          },
          selectedIconTheme: IconThemeData(color: Colors.green),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: "Projects",

            ),

            BottomNavigationBarItem(
              icon: Icon(
                  Icons.contact_phone
              ),
              label: "Contact",
            ),
          ],
        ),
      ),
    );
  }
}
