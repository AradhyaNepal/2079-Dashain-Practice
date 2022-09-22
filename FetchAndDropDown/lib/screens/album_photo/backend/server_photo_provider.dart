import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:practice/metadata/ServerPhotoModel.dart';
import 'package:http/http.dart' as http;
import 'package:practice/metadata/album_details_model.dart';
import 'package:practice/metadata/assets_location.dart';
import 'package:practice/metadata/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ServerPhotoProvider with ChangeNotifier{
  List<PhotoModel> serverDataList=[];
  bool isLoading=true;

  List<AlbumDetailsModel> uniqueAlbumList=[];

  ServerPhotoProvider(){
    fetchDataFromServer();
  }

  void getUniqueAlbumList(var responseData){
    List<int> repeatedList=[];
    for(Map data in responseData){
      repeatedList.add(data[PhotoModel.albumIdName]);
    }
    uniqueAlbumList=repeatedList.toSet().map((e) => AlbumDetailsModel(albumId: e, count: 0)).toList();
  }


  Future<void> fetchDataFromServer() async{
    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/photos");
    final respone=await http.get(uri);
    if(respone.statusCode>299) throw HttpException("Error");
    final responseData=json.decode(respone.body);
    serverDataList.clear();//TO clear old list
    uniqueAlbumList.clear();//First clear old
    getUniqueAlbumList(responseData);// THen add new
    for(var singleMap in responseData){
      int albumIndex=uniqueAlbumList.indexWhere((element) => element.albumId==singleMap[PhotoModel.albumIdName]);
      uniqueAlbumList[albumIndex].count=uniqueAlbumList[albumIndex].count+1;
      if(uniqueAlbumList[albumIndex].count<=3){// 4 means 3 items already added before
        serverDataList.add(PhotoModel.fromMap(singleMap));
      }

    }
    isLoading=false;
    notifyListeners();
  }



  Future<void> saveDataToSharedPreferences() async{
    List<Map> mapList=serverDataList.map((e) => e.getMap()).toList();
    String value = json.encode(mapList);
    final sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString(AssetsLocation.sharedPrefLocalDataKey, value);
  }


}