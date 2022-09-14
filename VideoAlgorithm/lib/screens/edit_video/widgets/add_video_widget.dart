
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';
import 'package:video_algorithm/screens/edit_video/play_specific_video.dart';
import 'package:video_algorithm/screens/edit_video/provider/add_video_provider.dart';

import '../../../common/color.dart';

class AddVideoWidget extends StatefulWidget {
  const AddVideoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddVideoWidget> createState() => _AddVideoWidgetState();
}

class _AddVideoWidgetState extends State<AddVideoWidget> {

  String? videoLocation;
  @override
  void initState() {
    // TODO: implement initState
    videoLocation=Provider.of<AddVideoProvider>(context,listen: false).videoLocation;
    FocusManager.instance.primaryFocus?.unfocus();
    print("I was in init Video Add");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.kPrimaryColor,
      child: Column(
        children: [
          Text(
            "Add Video",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: ColorConstant.kSecondaryColor
            ),

          ),

          Spacer(),
          Icon(
            videoLocation!=null?Icons.done:Icons.close,
            size: 200,
            color:  videoLocation!=null?Colors.green:ColorConstant.kSecondaryColor,
          ),
          Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                videoLocation!=null?ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor:Colors.green),
                    onPressed: () {
                      Navigator.pushNamed(context, PlaySpecificVideo.route,arguments: VideoModel(id: -1, name: "", location: videoLocation??"", repetition: -1, length: -1, isDefault: false));

                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Play Video",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ):SizedBox(),
                SizedBox(height: videoLocation!=null?15:0,),
                Consumer<AddVideoProvider>(
                  builder: (context,provider,child) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor:ColorConstant.kSecondaryColor),
                        onPressed: () async{
                          final ImagePicker picker = ImagePicker();
                          XFile? video=await picker.pickVideo(source: ImageSource.gallery);
                          if(video!=null){

                            videoLocation=video.path;
                            provider.setLocation(video.path);
                            setState(() {

                            });
                          }

                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            videoLocation!=null?"Change Video":"Choose Video",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    );
                  }
                ),
              ],
            ),
          ),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}
