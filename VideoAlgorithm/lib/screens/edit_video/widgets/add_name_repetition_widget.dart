import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/common/theme.dart';
import 'package:video_algorithm/screens/edit_video/provider/add_video_provider.dart';
import 'package:video_player/video_player.dart';

class AddNameRepetitionWidget extends StatefulWidget {
  const AddNameRepetitionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNameRepetitionWidget> createState() => _AddNameRepetitionWidgetState();
}

class _AddNameRepetitionWidgetState extends State<AddNameRepetitionWidget> {
  String nameValue="";
  int repetitionValue=1;
  bool isSaving=false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AddVideoProvider>(
      builder: (context,provider,child) {
        return Container(
          color: ColorConstant.kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Text(
                  "Add Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: ColorConstant.kSecondaryColor
                  ),

                ),


                Spacer(),
                TextField(
                  decoration: CustomTheme.getDecorationWithLabel("Video Name"),
                  onChanged: (value){
                    nameValue=value;
                    provider.setName(nameValue);
                    setState(() {
                    });
                  },
                ),
                SizedBox(height: 15,),
                Text(
                  "Repetition: $repetitionValue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17.5
                  ),
                ),
                Slider(

                    activeColor: ColorConstant.kSecondaryColor,
                    min: 1,
                    max: 10,
                    divisions: 10,
                    value: repetitionValue.toDouble(),
                    onChanged: (value){
                      setState(() {
                        repetitionValue=value.toInt();
                        provider.setRep(repetitionValue);
                      });
                    }
                ),

                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: isSaving || true?CircularProgressIndicator():ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor:ColorConstant.kSecondaryColor),
                      onPressed: !provider.canAdd()?null:
                          () async{
                        setState(() {
                          isSaving=true;
                        });
                        final String duplicateFilePath = (await getApplicationDocumentsDirectory()).path;
                        final fileName = basename(provider.videoLocation!);
                        String path='$duplicateFilePath/$fileName';
                        await XFile(provider.videoLocation!).saveTo(path);
                        VideoPlayerController controller = VideoPlayerController.file(File(provider.videoLocation!));
                        await controller.initialize();
                        await Provider.of<VideosDatabase>(context,listen: false).insertVideoIntoDatabase(
                            name: fileName,
                            location: path,
                            repetition: provider.repetition,
                            isDefault: false,
                            videoLength: controller.value.duration.inSeconds
                        );
                        await controller.dispose();
                        setState(() {
                          isSaving=false;
                        });
                        await Provider.of<VideosDatabase>(context,listen: false).getVideosList();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:
                        Text(
                          !provider.canAdd()?"Can't Add!!":"Save",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                  ),
                ),


                SizedBox(height: 40,)
              ],
            ),
          ),
        );
      }
    );
  }
}