import 'package:flutter/widgets.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/class/time_dealer.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';
class VideoBackup{
  int id,playedTime;
  VideoBackup({
    required this.id,
    required this.playedTime
  });
}


class AlgorithmVideoProvider with ChangeNotifier{
  //Time Calculated in Seconds
  int minTime=0;
  int maxTime=0;
  int currentTime=0;
  List<VideoModel> timeFrameVideos=[];
  int oneRepTime=0;
  List<VideoBackup> backupVideos=[];
  VideosDatabase videosDatabase;
  AlgorithmVideoProvider({
    required this.videosDatabase
  }){
    initialize();
  }

  void updateCurrentTime(int currentTime){
    this.currentTime=currentTime;
    oneRepTime=currentTime~/timeFrameVideos.length;
    notifyListeners();
  }
  void initialize(){
    int totalReps=0;
    for(VideoModel videoModel in videosDatabase.videosList){
      maxTime=videoModel.length*videoModel.repetition+maxTime;//All videos and its reps can be according to its full length
      totalReps=videoModel.repetition+totalReps;

      for(int i=0;i<videoModel.repetition;i++){//Add all repetitions in the time frame
        timeFrameVideos.add(videoModel);
      }
    }
    minTime=totalReps*5;//Every video and its rep must be played for minimum 5 seconds
    currentTime=maxTime;//Default
    oneRepTime=currentTime~/timeFrameVideos.length;
  }




  bool videoPlaying=false;
  void videoStarted(){//Use to shuffle list before playing, to create new time frame
    if(videoPlaying==false){
      videoPlaying=true;
      timeFrameVideos.shuffle();
      notifyListeners();//We need to provide new value of time frame to the list
    }
  }

  String getTimeFrameDetails(){
    String text="Total Time : ${TimeDealer.getTimeFromSecond(currentTime)}\nEvery Repetition Time: ${TimeDealer.getTimeFromSecond(oneRepTime)}\n";
    for(int i =1;i<=timeFrameVideos.length;i++){
      text="$i) $text${timeFrameVideos[i].name}\n";
    }
    return text;
  }

  void videoClosed(){
    backupVideos.clear();
    videoPlaying=false;
  }


  void changeCurrentTime(int currentTime){
    this.currentTime=currentTime;
  }



}