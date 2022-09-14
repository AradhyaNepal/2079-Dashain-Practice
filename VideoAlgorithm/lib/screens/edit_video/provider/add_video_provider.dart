import 'package:flutter/material.dart';

class AddVideoProvider with ChangeNotifier{
  String? videoLocation;
  String? videoName;
  int repetition=1;
  bool isSaving=false;

  bool canAdd(){
    return videoLocation!=null && videoName!=null && videoName!.trim()!="";
  }

  void setRep(int rep){
    repetition=rep;
    notifyListeners();
  }

  void setName(String name){
    videoName=name;
    notifyListeners();
  }

  void setLocation(String loc){
    videoLocation=loc;
    notifyListeners();
  }

  void setSaving(bool saving){
    isSaving=saving;
    notifyListeners();
  }
}