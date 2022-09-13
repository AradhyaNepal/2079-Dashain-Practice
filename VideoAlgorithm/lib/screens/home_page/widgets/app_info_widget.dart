import 'package:flutter/material.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/common/constant.dart';

class AppInfoWidget extends StatelessWidget {
  const AppInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Apps Info"),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Text(
            Constant.howAppWorks
        ),
      ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              "Okay",
              style: TextStyle(
                  color: ColorConstant.kSecondaryColor
              ),
            )
        ),
      ],
    );
  }
}