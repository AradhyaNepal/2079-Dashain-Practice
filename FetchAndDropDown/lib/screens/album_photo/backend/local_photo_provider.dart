import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practice/metadata/ServerPhotoModel.dart';
import 'package:practice/metadata/album_details_model.dart';
import 'package:practice/metadata/assets_location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPhotoProvider with ChangeNotifier{
  List<PhotoModel> localPhotoList=[];
  List<AlbumDetailsModel> uniqueAlbumList=[];
  bool isLoading=true;


  LocalPhotoProvider(){
    fetchDataFromLocal();
  }
  void getUniqueAlbumList(){
    List<int> repeatedList=[];
    for(PhotoModel data in localPhotoList){
      repeatedList.add(data.albumId);
    }
    uniqueAlbumList=repeatedList.toSet().map((e) => AlbumDetailsModel(albumId: e, count: 0)).toList();
  }


  Future<void> fetchDataFromLocal() async{
    localPhotoList.clear();//TO clear old list
    uniqueAlbumList.clear();//First clear old
    final sharedPref=await SharedPreferences.getInstance();
    String? savedValue=sharedPref.getString(AssetsLocation.sharedPrefLocalDataKey);

    if(savedValue==null){
      return;//No value saved locally
    }
    final jsonValue=json.decode(savedValue);
    for(var single in jsonValue){
      localPhotoList.add(PhotoModel.fromMap(single));
    }
    getUniqueAlbumList();
    isLoading=false;
    notifyListeners();

  }
}