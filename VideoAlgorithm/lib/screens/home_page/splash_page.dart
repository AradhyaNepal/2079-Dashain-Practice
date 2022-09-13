import 'package:flutter/material.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/common/constant.dart';
import 'package:video_algorithm/metadata/assets_location.dart';
import 'package:video_algorithm/screens/home_page/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String route="/";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, HomePage.route);
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: ColorConstant.kPrimaryColor,
          height: size.height,
          width: size.width,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Hero(
                    tag: Constant.splashHeroTag,
                    child: Image.asset(
                        AssetsLocation.appLogo
                    ),
                  )
              ),
              SizedBox(height: 20,),
              CircularProgressIndicator(
                color: ColorConstant.kSecondaryColor,
              )
            ],
          ),
        ),

      ),
    );
  }
}
