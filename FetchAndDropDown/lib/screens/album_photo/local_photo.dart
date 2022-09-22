import 'package:flutter/material.dart';
import 'package:practice/screens/album_photo/backend/local_photo_provider.dart';
import 'package:practice/screens/album_photo/widgets/items_widget.dart';
import 'package:provider/provider.dart';

class LocalPhoto extends StatelessWidget {
  const LocalPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create:(context)=>LocalPhotoProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Fetch Practice"),

          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: Consumer<LocalPhotoProvider>(
                builder: (context,provider,child) {
                  return Container(
                    height: size.height,
                    width: size.width,
                    child: provider.isLoading?
                    Center(child: CircularProgressIndicator(),):
                    provider.localPhotoList.length==0?
                    Center(
                      child: Text(
                        "No Items"
                      ),
                    ):
                    GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: provider.uniqueAlbumList.length,
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context,index){
                          return ItemWidget(
                            serverPhotoModel: provider.localPhotoList[index],
                          );
                        }
                    ),
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
