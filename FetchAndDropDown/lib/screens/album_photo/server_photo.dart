import 'package:flutter/material.dart';
import 'package:practice/screens/album_photo/backend/server_photo_provider.dart';
import 'package:practice/screens/album_photo/widgets/items_widget.dart';
import 'package:provider/provider.dart';

class ServerPhoto extends StatelessWidget {
  const ServerPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>ServerPhotoProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            title: Center(
              child: Text(
                  "Fetch Practice"
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                  },
                  child: Consumer<ServerPhotoProvider>(
                    builder: (context,provider,child) {
                      return provider.isLoading?SizedBox():
                      TextButton(
                        onPressed: () async{
                          await provider.saveDataToSharedPreferences();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Saved Locally")));
                        },
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      );
                    }
                  )
              )
            ],
          ),
          body: Consumer<ServerPhotoProvider>(
            builder: (context,provider,child) {
              return Container(
                height: size.height,
                width: size.width,
                child: provider.isLoading?
                Center(child: CircularProgressIndicator(),):
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
                        serverPhotoModel: provider.serverDataList[index],
                      );
                    }
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}


