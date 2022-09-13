import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:video_algorithm/common/constant.dart';
import 'package:video_algorithm/metadata/assets_location.dart';
import 'package:video_algorithm/metadata/model/videos_model.dart';
import 'package:video_player/video_player.dart';

class VideosDatabase with ChangeNotifier{
  static const String videoTableName="VideosTable",idCol="id",nameCol="name",locationCol="location",repetitionCol="repetition",defaultCol="isDefault",videoSecondCol="videoSeconds";
  bool isInitialized=false;
  Database? db;

  void initialize() async{
    var databasesPath = await getDatabasesPath();
    db = await openDatabase(databasesPath+Constant.databaseName, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $videoTableName ('
                  '$idCol INTEGER PRIMARY KEY AUTOINCREMENT,'
                  ' $nameCol TEXT,'
                  ' $locationCol TEXT,'
                  ' $repetitionCol INTEGER,'
                  ' $defaultCol BOOL,'
                  ' $videoSecondCol INTEGER )');
          await addDefaultVideos(db);
          print("Database created with initial data");

        });
    isInitialized=true;
    notifyListeners();
  }

  Future<void> addDefaultVideos(Database db) async{
    for(int i=0;i<Constant.defaultVideosName.length;i++){
      String location="assets/videos/"+Constant.defaultVideosName[i]+".mp4";
      VideoPlayerController controller = VideoPlayerController.asset(location);
      await controller.initialize();
      print("Duration"+controller.value.duration.inSeconds.toString());
      await insertVideoIntoDatabase(
          name: Constant.defaultVideosName[i],
          location: location,
          repetition: i+1,
          isDefault: true,
          videoLength: controller.value.duration.inSeconds,
          firstDb: db
      );
      await controller.dispose();
    }

  }

  Future<void> insertVideoIntoDatabase({
    required String name,
    required String location,
    required int repetition,
    required bool isDefault,
    required int videoLength,
    Database? firstDb,//When table is being created at the beginning
  }) async{

    await (db??firstDb!).transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $videoTableName('
              '$nameCol,'
              '$locationCol,'
              '$repetitionCol,'
              '$defaultCol,'
              '$videoSecondCol'
              ') VALUES('
              '"$name",'
              '"$location",'
              '$repetition,'
              '${isDefault?1:0},'
              '$videoLength)'
      );
    });


  }

  Future<List<VideoModel>> getVideosList () async{
    List<VideoModel> list=[];
    final data=await db!.rawQuery('SELECT * FROM $videoTableName');
    for(final value in data){
      list.add(VideoModel.fromMap(value));
    }
    print(data.length);
    print(list.length);
    return list;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    closeDb();
    super.dispose();
  }
  void closeDb() async{
    if(db!=null){
      await db!.close();
    }
  }
}