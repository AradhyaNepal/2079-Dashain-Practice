import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/screens/edit_video/videos_list.dart';
import 'package:video_algorithm/screens/home_page/home_page.dart';
import 'package:video_algorithm/screens/home_page/splash_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ColorConstant.kPrimaryColor, // navigation bar color
    statusBarColor:  ColorConstant.kSecondaryColor, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>VideosDatabase())
      ],
      child: MaterialApp(
        title: 'Video Algorithm',
        theme: ThemeData(
          colorScheme: const ColorScheme.light().copyWith(primary:ColorConstant.kPrimaryColor,secondary: ColorConstant.kSecondaryColor),
        ),
        initialRoute: SplashPage.route,
        routes: {
          SplashPage.route:(context)=>const SplashPage(),
          HomePage.route:(context)=>const HomePage(),
          VideosList.route:(context)=>const VideosList()
        },
      ),
    );
  }
}
