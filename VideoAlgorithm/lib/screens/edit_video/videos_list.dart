import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';

class VideosList extends StatelessWidget {
  static const String route="VideosList";
  const VideosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: ColorConstant.kSecondaryColor,
          padding: EdgeInsets.all(8),
          height: size.height,
          width: size.width,
          child: Consumer<VideosDatabase>(
            builder: (context,provider,child) {
              if(!provider.isInitialized){
                print("Initialized: ${provider.isInitialized}");
                return Center(
                  child: LinearProgressIndicator(),
                );
              }
              return FutureBuilder<List<VideoModel>>(
                future: provider.getVideosList(),
                builder: (context,snapShot) {
                  if(snapShot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapShot.hasError){
                    print(snapShot.error.toString());
                    print(snapShot.stackTrace.toString());
                    return Text("Error");
                  }
                  List<VideoModel> value=snapShot.data!;
                  return ListView.builder(
                    itemCount:value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 100,
                        child: Text(
                          value[index].name+" "+value[index].length.toString(),
                          style: TextStyle(
                            color: Colors.black
                          ),
                        ),
                      );
                    } ,
                  );
                }
              );
            }
          ),
        ),
      ),
    );
  }
}
