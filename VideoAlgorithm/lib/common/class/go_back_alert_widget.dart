
import 'package:flutter/material.dart';
import 'package:video_algorithm/common/color.dart';

class GoBackAlertWidget extends StatelessWidget {
  const GoBackAlertWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Go Back"),
      content: Text("Do you really want to go back?"),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context,true);
            },
            child: Text(
              "Yes",
              style: TextStyle(
                  color: ColorConstant.kSecondaryColor
              ),
            )
        ),
        TextButton(
            onPressed: (){
              Navigator.pop(context,false);
            },
            child: Text(
              "No",
              style: TextStyle(
                  color: Colors.black
              ),
            )
        ),
      ],
    );
  }
}
