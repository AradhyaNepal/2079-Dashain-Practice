
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/custom_snackbar.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/class/time_dealer.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';
import 'package:video_algorithm/screens/edit_video/edit_video.dart';
import 'package:video_algorithm/screens/edit_video/play_specific_video.dart';
import 'package:video_player/video_player.dart';

class VideoListWidget extends StatefulWidget {
  const VideoListWidget({
    Key? key,
    required this.value,
  }) : super(key: key);

  final VideoModel value;

  @override
  State<VideoListWidget> createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  bool deleting=false;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: deleting,
      child: Card(
        margin: EdgeInsets.all(7.5),
        elevation: 10,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(17.5),
              child: IconButton(
                iconSize: 50,
                onPressed: (){

                  Navigator.pushNamed(context, PlaySpecificVideo.route,arguments: widget.value);
                },
                icon: Icon(
                  Icons.play_arrow_rounded,
                  color: ColorConstant.kPrimaryColor,


                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.value.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.value.repetition.toString()+" Repetitions",
                    style:TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline
                    ),
                  ),
                  Text(
                      TimeDealer.getTimeFromSecond(widget.value.length),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),


                ],
              ),
            ),
            IconButton(
              iconSize: 25,
              onPressed: (){
                Navigator.pushNamed(context, EditVideo.route,arguments: widget.value);
              },
              icon: Icon(
                Icons.edit,
                color: ColorConstant.kPrimaryColor,


              ),
            ),
            deleting?CircularProgressIndicator(color: ColorConstant.kSecondaryColor,):IconButton(
              iconSize: 25,
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Delete Video?"),
                        content: Text("Do you really want to delete this video?"),
                        actions: [
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context,true);
                              },
                              child: Text(
                                  "Yes",
                                style: TextStyle(
                                  color: ColorConstant.kSecondaryColor,
                                ),
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
                ).then((value) async{
                  if(value==true) {
                    setState(() {
                      deleting=true;
                    });
                    int items= Provider.of<VideosDatabase>(context,listen: false).videosList.length;
                    if(items>3){
                      if(widget.value.isDefault==false){
                        File file=File(widget.value.location);
                        await file.delete();
                      }
                      await Provider.of<VideosDatabase>(context,listen: false).deleteAVideo(widget.value.id);
                      showCustomSnackBar(context,"Successfully Deleted");

                    }
                    else{
                      showCustomSnackBar(context,"Minimum 3 Videos Required");
                    }
                    setState(() {
                      deleting=false;
                    });

                  }
                });
              },
              icon: Icon(
                Icons.delete,
                color: ColorConstant.kSecondaryColor,


              ),
            ),
          ],
        ),
      ),
    );
  }


}