import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';
import 'package:video_algorithm/screens/play_video/provider/algorithm_video_provider.dart';
import 'package:video_player/video_player.dart';

class PlayAlgorithmVideo extends StatefulWidget {
  static const route = "PlayAlgorithmVideo";

  const PlayAlgorithmVideo({Key? key}) : super(key: key);

  @override
  State<PlayAlgorithmVideo> createState() => _PlayAlgorithmVideoState();
}

class _PlayAlgorithmVideoState extends State<PlayAlgorithmVideo> {
  ValueNotifier<int> indexNotifier=ValueNotifier(0);
  VideoPlayerController? controller;

  Timer? timer;
  bool initialized=false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setUpVideoTimer();
    });
  }

  void setUpVideoTimer() async{
    final provider = Provider.of<AlgorithmVideoProvider>(context, listen: false);
    provider.videoClosed();//To dispose old data
    provider.videoStarted();//To shuffle the list
    await playVideo(provider.timeFrameVideos[indexNotifier.value]);//In first play these is never old backup
    setState(() {});
    print("I was here 2");

    timer =Timer.periodic(Duration(seconds: provider.oneRepTime), (timer) async {
      nextAndPlayAgainCheck(provider);
    }
    );

  }

  void nextAndPlayAgainCheck(AlgorithmVideoProvider provider)async{

    for(int j=0;j<provider.backupVideos.length;j++){
      //Remove old backup
      if(provider.backupVideos[j].id==provider.timeFrameVideos[indexNotifier.value].id){
        provider.backupVideos.removeAt(j);
      }
    }
    provider.backupVideos.add(
      //Add new backup so than on next repetition video could be played from paused location
        VideoBackup(
            id: provider.timeFrameVideos[indexNotifier.value].id,
            playedTime: controller!.value.position.inSeconds
        )
    );
    indexNotifier.value++;
    if(indexNotifier.value<provider.timeFrameVideos.length){
      controller!.dispose();
      controller=null;

      //Find Old backup duration, if video was paused before and now we need to start it from that location
      int backupTime=0;
      for(int j=0;j<provider.backupVideos.length;j++){
        if(provider.backupVideos[j].id==provider.timeFrameVideos[indexNotifier.value].id){
          backupTime=provider.backupVideos[j].playedTime;//Last played time added. Although its always one time
        }
      }
      await playVideo(provider.timeFrameVideos[indexNotifier.value],initialDuration: backupTime);
      setState(() {
      });
    }
    else{
      timer!.cancel();
      controller!.pause();
      showDialog(
          context: context,
          builder: (controller){
            return AlertDialog(
              title: Text("Play Again"),
              content: Text(
                  "Do you want to shuffle the playlist and play the video again.\nIf no, this page will close."
              ),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context,true);
                    },
                    child: Text("Yes")
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
          indexNotifier.value=0;
          setUpVideoTimer();
        }else{
          Navigator.pop(context);
        }
      });
    }
  }

  Future<void> playVideo(VideoModel model,{int initialDuration=0}) async{
    if (model.isDefault) {
      controller = VideoPlayerController.asset(model.location);
    } else {
      controller = VideoPlayerController.file(File(model.location));
    }
    print("Play Duration $initialDuration");
    await controller!.initialize();
    controller!.seekTo(Duration(seconds: initialDuration));
    controller!.setLooping(true);
    controller!.play();
    initialized=true;
    print("I was here 1");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          color: Colors.black,
          child: initialized
              ? Consumer<AlgorithmVideoProvider>(
                builder: (context,provider,child) {
                  return Stack(
                    children: [

                      Positioned.fill(
                        child: VideoPlayer(
                          controller!
                        )
                      ),
                      Positioned(
                        bottom: 50,
                        left: 50,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white.withOpacity(0.8),
                          child: Text(
                            provider.timeFrameVideos[indexNotifier.value].name,
                            style: TextStyle(
                              color: ColorConstant.kSecondaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                      ),
                      indexNotifier.value<provider.timeFrameVideos.length-1?Positioned(
                        top: 5,
                        left: 5,
                        child: TextButton(
                          onPressed: (){
                            timer!.cancel();
                            nextAndPlayAgainCheck(Provider.of<AlgorithmVideoProvider>(context,listen: false));
                            timer=Timer.periodic(Duration(seconds: provider.oneRepTime), (timer) async {
                              nextAndPlayAgainCheck(provider);
                            });
                          },
                          child: Text(
                            "Skip"
                          ),
                        ),
                      ):SizedBox(),
                      indexNotifier.value<provider.timeFrameVideos.length-1?Positioned(
                        bottom: 50,
                        right: 50,
                        child: Container(

                          padding: EdgeInsets.all(10),
                          color: Colors.white.withOpacity(0.8),
                          child: Text(
                              "Next: ${provider.timeFrameVideos[indexNotifier.value+1].name}",
                            style: TextStyle(
                            color: ColorConstant.kSecondaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                      ):SizedBox(),
                      Positioned(
                          top: 20,
                          right: 30,
                          child: IconButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return ValueListenableBuilder(
                                      valueListenable: indexNotifier,
                                      builder: (context,value,child) {
                                        return AlertDialog(
                                          title: Text("Time Frame Info"),
                                          content: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: Text(
                                                provider.getTimeFrameDetails(indexNotifier.value)
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Okay!")
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  }
                              );
                            },
                            icon: Icon(
                              Icons.info,
                              size: 40,
                              color: ColorConstant.kSecondaryColor,
                            ),
                          )
                      ),
                    ],
                  );
                }
              )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  @override
  void dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if(controller!=null){
      controller!.dispose();

    }
    if (timer != null) {
      timer?.cancel();
    }
    Provider.of<AlgorithmVideoProvider>(context,listen: false).videoClosed();
    super.dispose();
  }
}
