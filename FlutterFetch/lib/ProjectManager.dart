import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterfetch/ProjectPage.dart';
import 'package:http/http.dart' as http;

class ProjectManager with ChangeNotifier{
  bool isLoading=true;
  List<Project> projectList=[];
  ProjectManager(){
    fetchList();
  }

  Future<void> fetchList() async{
     Uri uri=Uri.parse("http://admin.ecohotindustries.com/api/project/");
     final response=await http.get(uri);
     final responseData=json.decode(response.body)["projects"];
     for(var single in responseData){
       projectList.add(Project(image: single["image"], heading: single["title"], subText: single["summary"], slug: single["slug"],description: single["description"]));
     }
     isLoading=false;
     notifyListeners();
  }
}