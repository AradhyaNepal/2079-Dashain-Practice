import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/custom_snackbar.dart';
import 'package:video_algorithm/common/class/time_dealer.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/screens/play_video/provider/algorithm_video_provider.dart';

class VideoTimeFrameSetting extends StatefulWidget {
  static const route="VideoTimeFrameSetting";

  @override
  State<VideoTimeFrameSetting> createState() => _VideoTimeFrameSettingState();
}

class _VideoTimeFrameSettingState extends State<VideoTimeFrameSetting> {
  int currentTime=0;
  bool loading=true;
  late AlgorithmVideoProvider provider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider=Provider.of<AlgorithmVideoProvider>(context,listen: false);
      currentTime=provider.currentTime;
      loading=false;
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            color: ColorConstant.kPrimaryColor,
            child: loading?
                Center(
                  child: CircularProgressIndicator(),
                )
                :Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                    "Time Frame",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: ColorConstant.kSecondaryColor
                  ),
                ),
                SizedBox(height: 10,),
                Slider(
                    min: provider.minTime.toDouble(),
                    max: provider.maxTime.toDouble(),
                    value: currentTime.toDouble(),
                    activeColor: ColorConstant.kSecondaryColor,
                    onChanged: (value){
                      setState(() {
                        currentTime=value.toInt();
                      });
                    }
                ),

                SizedBox(height: 10,),
                Text(
                    TimeDealer.getTimeFromSecond(currentTime),
                  style: TextStyle(
                    fontSize: 22.5,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: size.width*0.75,
                  child: ElevatedButton(
                      onPressed: (){
                        Provider.of<AlgorithmVideoProvider>(context,listen: false).updateCurrentTime(currentTime);
                        showCustomSnackBar(context, "Successfully Updated!!");
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Save",
                          style: TextStyle(
                            fontSize: 25
                          ),
                        ),
                      )
                  ),
                ),
                SizedBox(height: 40,)
              ],
            )
          ),
        )
    );
  }
}
