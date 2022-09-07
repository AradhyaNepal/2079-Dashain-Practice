import 'package:flutter/material.dart';
import 'package:flutterfetch/one_provider.dart';
import 'package:flutterfetch/two_provider.dart';
import 'package:provider/provider.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Consumer<OneProvider>(
      builder: (context,value,child){
        return value.isLoading?Center(child: CircularProgressIndicator(),):
        SafeArea(
          child: Scaffold(
            body: Container(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                itemBuilder: (context,index){
                  return ItemCard(post: value.postList[index],comment: value.getComment(value.postList[index].id),);
                },
                itemCount: value.postList.length,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ItemCard extends StatefulWidget {
  Post post;
  List<String> comment;
  ItemCard({
    required this.post,
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool showComment=true;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "id :"+widget.post.id.toString()
                ),
                Text(
                    widget.post.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red
                  ),
                ),
                for (int i=0;i<widget.comment.length;i++)
                  Card(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          widget.comment[i]
                      ),
                    ),
                  )


              ],
            ),
          ),

        ],
      ),
    );
  }
}
