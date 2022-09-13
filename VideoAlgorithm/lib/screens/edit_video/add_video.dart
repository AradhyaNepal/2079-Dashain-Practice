import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/screens/edit_video/provider/add_video_provider.dart';
import 'package:video_algorithm/screens/edit_video/widgets/add_name_repetition_widget.dart';
import 'package:video_algorithm/screens/edit_video/widgets/add_video_widget.dart';

class AddVideoPage extends StatelessWidget {
  static const String route="AddVideo";
  AddVideoPage({Key? key}) : super(key: key);
  final PageController pageController=PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Go Back?"),
                content: Text("Are you sure you want to go back? You might loose all your progress."),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context,true);
                      },
                      child: Text(
                          "Yes",
                      )
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context,false);
                      },
                      child: Text(
                          "No",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      )
                  ),
                ],
              );
            }
        ).then((value) {
          if(value==true){
            Navigator.pop(context);
          }
        });
        return false;
      },
      child: SafeArea(
        child: Scaffold(

          body: Container(
            color: ColorConstant.kPrimaryColor,
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(height: 20,),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 2,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: ColorConstant.kSecondaryColor,
                    dotColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ChangeNotifierProvider(
                    create: (context)=>AddVideoProvider(),
                    child: PageView(
                      controller: pageController,
                      physics: BouncingScrollPhysics(),
                      children: [
                        AddVideoWidget(),
                        AddNameRepetitionWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


