
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/custom_snackbar.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/class/time_dealer.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(17.5),
                child: IconButton(
                    iconSize: 50,
                  onPressed: (){},
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
                        "Duration: "+TimeDealer.getTimeFromSecond(widget.value.length),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                        widget.value.repetition.toString()+" Repetitions",
                      style:TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  ],
                ),
              ),
              IconButton(
                iconSize: 25,
                onPressed: (){},
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
      ),
    );
  }
}