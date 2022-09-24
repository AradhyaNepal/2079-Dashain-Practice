import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';
import 'package:video_player/video_player.dart';

class PlaySpecificVideo extends StatefulWidget {
  static const String route="PlaySpecificVideo";
  const PlaySpecificVideo({Key? key}) : super(key: key);

  @override
  State<PlaySpecificVideo> createState() => _PlaySpecificVideoState();
}

class _PlaySpecificVideoState extends State<PlaySpecificVideo> {

  late ChewieController chewieController;
  late VideoPlayerController controller;
  bool loading=true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
      VideoModel model=ModalRoute.of(context)?.settings.arguments as VideoModel;
      if(model.isDefault){
        controller = VideoPlayerController.asset(model.location);
      }else{
        controller = VideoPlayerController.file(File(model.location));
      }

      await controller.initialize();
      chewieController = ChewieController(
        fullScreenByDefault: false,
        allowFullScreen: false,
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
      );
      setState(() {
        loading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(
          child: CircularProgressIndicator(),
        ): Container(
          color: Colors.black,
          height: size.height,
          width: size.width,
          child: Stack(
            children: [

              Positioned.fill(
                child: Chewie(
                  controller: chewieController,
                ),
              ),
              Positioned(
                  top: 5,
                  left: 5,
                  child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,color: Colors.red,),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    controller.dispose();
    chewieController.dispose();

    super.dispose();
  }
}
