import 'package:video_algorithm/common/class/database.dart';

class VideoModel{
  String name,location;
  int id,repetition,length;
  bool isDefault;
  VideoModel({
    required this.id,
    required this.name,
    required this.location,
    required this.repetition,
    required this.length,
    required this.isDefault
  });

  factory VideoModel.fromMap(Map value){
    return VideoModel(
        id: value[VideosDatabase.idCol],
        name: value[VideosDatabase.nameCol],
        location: value[VideosDatabase.locationCol],
        repetition: value[VideosDatabase.repetitionCol],
        length: value[VideosDatabase.videoSecondCol],
        isDefault: value[VideosDatabase.defaultCol]==1?true:false
    );
  }
}