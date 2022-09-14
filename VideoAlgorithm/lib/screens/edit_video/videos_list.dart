import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/custom_snackbar.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/screens/edit_video/add_video.dart';
import 'package:video_algorithm/screens/edit_video/video_timeframe.dart';
import 'package:video_algorithm/screens/edit_video/widgets/video_list_widget.dart';

class VideosList extends StatelessWidget {
  static const String route="VideosList";
  const VideosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.kSecondaryColor,
          title: Row(
            children: [
              Text(
                  "Videos"
              ),
              Spacer(),

              Consumer<VideosDatabase>(
                builder: (context,provider,child) {
                  return provider.isInitialized?Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, VideoTimeFrameSetting.route);
                          },
                          icon: Icon(
                              Icons.settings
                          )
                      ),
                      IconButton(
                        onPressed: (){
                          if(provider.videosList.length==10){
                            showCustomSnackBar(context, "Maximum 10 Videos Allowed");
                          }else{
                            Navigator.of(context).pushNamed(AddVideoPage.route);
                          }
                        },
                        icon: Icon(
                            Icons.add
                        ),
                      ),
                    ],
                  ):CircularProgressIndicator();
                }
              )
            ],
          ),
        ),
        body: Container(
          color: ColorConstant.kPrimaryColor,
          padding: EdgeInsets.only(top: 8,left: 8,right: 8),
          height: size.height,
          width: size.width,
          child: Consumer<VideosDatabase>(
            builder: (context,provider,child) {
              if(!provider.isInitialized && provider.videosLoading){
                return Center(
                  child: CircularProgressIndicator(color: ColorConstant.kSecondaryColor,),
                );
              }
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount:provider.videosList.length,
                itemBuilder: (BuildContext context, int index) {
                  return VideoListWidget(value: provider.videosList[index]);
                } ,
              );
            }
          ),
        ),
      ),
    );
  }
}

