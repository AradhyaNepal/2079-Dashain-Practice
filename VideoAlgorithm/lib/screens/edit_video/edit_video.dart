import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/common/theme.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';

class EditVideo extends StatefulWidget {
  static const String route="EditVideo";
  const EditVideo({Key? key}) : super(key: key);

  @override
  State<EditVideo> createState() => _EditVideoState();
}

class _EditVideoState extends State<EditVideo> {

  int repetitionValue=1;
  bool isSaving=false;
  late VideoModel videoModal;
  String textValue="";
  final TextEditingController initialValueController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      videoModal = ModalRoute.of(context)?.settings.arguments as VideoModel;
      repetitionValue=videoModal.repetition;
      textValue=videoModal.name;
      initialValueController.text=textValue;
      setState(() {

      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Details"),
        ),
        body: Container(
          color: ColorConstant.kPrimaryColor,
          child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Spacer(),
                TextField(
                  controller: initialValueController,
                  decoration: CustomTheme.getDecorationWithLabel("Video Name"),
                  onChanged: (value){
                    textValue=value;
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
                      });
                    }
                ),

                Spacer(),
                isSaving?
                CircularProgressIndicator()
                    :SizedBox(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor:ColorConstant.kSecondaryColor),
                      onPressed: textValue.trim()==""?null:
                          () async{
                        setState(() {
                          isSaving=true;
                        });

                        await Provider.of<VideosDatabase>(context,listen: false).updateAVideo(videoModal.id, repetitionValue, textValue);

                        setState(() {
                          isSaving=false;
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child:
                        Text(
                          textValue.trim()==""?"Can't Add!!":"Save",
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
        ),
      ),
    );
  }
}
