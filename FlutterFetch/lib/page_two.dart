import 'package:flutter/material.dart';
import 'package:flutterfetch/two_provider.dart';
import 'package:provider/provider.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Consumer<TwoProvider>(
      builder: (context,value,child){
        return value.isLoading?Center(child: CircularProgressIndicator(),):
        SafeArea(
          child: Scaffold(
            body: Container(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                itemBuilder: (context,index){
                  return Container(
                    child: Text(value.commentList[index].body),
                  );
                },
                itemCount: value.commentList.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
