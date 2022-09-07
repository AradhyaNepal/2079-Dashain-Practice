import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Comment{
  int id,postId;
  String body;
  Comment({required this.id,required this.body,required this.postId});
}
class TwoProvider with ChangeNotifier{
  bool isLoading=true;
  List<Comment> commentList=[];
  TwoProvider(){
    fetchPost();
  }

  Future<void> fetchPost() async{
    Uri uri=Uri.parse("https://my-json-server.typicode.com/typicode/demo/comments");
    final response=await http.get(uri);
    final data=json.decode(response.body);
    for (var single in data){
      commentList.add(Comment(id: single["id"], body: single["title"],postId: single["postId"]));
    }
    isLoading=false;
    notifyListeners();
  }
}