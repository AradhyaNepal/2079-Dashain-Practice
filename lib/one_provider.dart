import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterfetch/two_provider.dart';
import 'package:http/http.dart' as http;

class Post{
  int id;
  String title;
  Post({required this.id,required this.title});
}
class OneProvider with ChangeNotifier{
  bool isLoading=true;
  List<Post> postList=[];
  List<Comment> commentList=[];
  OneProvider(){
    fetchPost().then((value){
      fetchComment();
    });
  }

  Future<void> fetchPost() async{
    Uri uri=Uri.parse("https://my-json-server.typicode.com/typicode/demo/posts");
    final response=await http.get(uri);
    final data=json.decode(response.body);
    for (var single in data){
      postList.add(Post(id: single["id"], title: single["title"]));
    }
    notifyListeners();
  }
  Future<void> fetchComment() async{

    Uri uri=Uri.parse("https://my-json-server.typicode.com/typicode/demo/comments");
    final response=await http.get(uri);
    final data=json.decode(response.body);
    for (var single in data){
      commentList.add(Comment(id: single["id"], body: single["body"],postId: single["postId"]));
    }
    isLoading=false;
    notifyListeners();
  }

  List<String> getComment(int postId) {
    List<String> commentStringList=[];
    for(int i=0;i<commentList.length;i++){
      if(commentList[i].postId==postId){
        commentStringList.add(commentList[i].body);
      }
    }
    return commentStringList;
  }
}