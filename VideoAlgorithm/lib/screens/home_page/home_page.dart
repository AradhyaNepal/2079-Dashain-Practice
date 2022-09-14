import 'package:flutter/material.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/common/constant.dart';
import 'package:video_algorithm/metadata/assets_location.dart';
import 'package:video_algorithm/screens/edit_video/videos_list.dart';
import 'package:video_algorithm/screens/home_page/widgets/app_info_widget.dart';

class HomePage extends StatelessWidget {
  static const String route="HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          color: ColorConstant.kPrimaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Hero(
                  tag: Constant.splashHeroTag,
                  child: Image.asset(
                      AssetsLocation.appLogo
                  ),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.kSecondaryColor),
                    onPressed: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 40,
                          ),
                          SizedBox(width: 10,),
                          Text(
                              "Play Videos",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.kSecondaryColor),
                    onPressed: (){
                      Navigator.of(context).pushNamed(VideosList.route);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            size: 40,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Edit Videos",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
              SizedBox(height: 5,),
              TextButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppInfoWidget();
                      },
                    );


                  },
                  child: Text(
                    "How This App Works?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15,

                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}


