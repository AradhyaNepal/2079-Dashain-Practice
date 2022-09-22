import 'package:flutter/material.dart';
import 'package:practice/metadata/ServerPhotoModel.dart';
import 'package:practice/metadata/assets_location.dart';

class ItemWidget extends StatelessWidget {
  final PhotoModel serverPhotoModel;
  const ItemWidget({
    required this.serverPhotoModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.5)
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                      AssetsLocation.dummyImage
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(15),
                      child: Text(
                        serverPhotoModel.albumId.toString(),
                      ),
                    ),
                  ),
                )
              ],
            ),

          ),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 1,
                child: ClipRRect(
                  child: Image.asset(
                      AssetsLocation.dummyImage
                  ),
                )
            ),
            SizedBox(width: 5,),
            Expanded(
              flex: 9,
                child: Text(
                    serverPhotoModel.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
            ),
          ],
        )

        
      ],
    );
  }
}