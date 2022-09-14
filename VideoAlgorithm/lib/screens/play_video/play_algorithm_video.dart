import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
  ChewieController? chewieController;
  VideoPlayerController? controller;
  int index = 0;
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
    await playVideo(provider.timeFrameVideos[index]);
    setState(() {});
    print("I was here 2");
    index++;
    timer =Timer.periodic(Duration(seconds: provider.oneRepTime), (timer) async {
      if(index<provider.timeFrameVideos.length){
        controller!.dispose();
        chewieController!.dispose();
        controller=null;
        chewieController=null;
        await playVideo(provider.timeFrameVideos[index]);
        setState(() {
          index++;
        });
      }
      else{
        timer.cancel();
        controller!.pause();
        chewieController!.pause();
        showDialog(
            context: context,
            builder: (controller){
              return AlertDialog(
                title: Text("Play Again"),
                content: Text(
                  "Do you want to shuffle the playlist and play the video agein.\nIf no, this page will close."
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
            index=0;
            setUpVideoTimer();
          }else{
            Navigator.pop(context);
          }
        });
      }
    }
    );

  }

  Future<void> playVideo(VideoModel model) async{
    if (model.isDefault) {
      controller = VideoPlayerController.asset(model.location);
    } else {
      controller = VideoPlayerController.file(File(model.location));
    }
    await controller!.initialize();
    chewieController = ChewieController(
      fullScreenByDefault: false,
      allowFullScreen: false,
      showControls: false,
      videoPlayerController: controller!,
      autoPlay: true,
      looping: true,
    );
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
              ? Chewie(
                  controller: chewieController!,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if(controller!=null){
      controller!.dispose();

    }
    if( chewieController!=null){
      chewieController!.dispose();
    }

    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }
}
