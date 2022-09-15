import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_algorithm/common/color.dart';

showCustomSnackBar(BuildContext context,String message){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
          content: Text(
              message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),

        backgroundColor: ColorConstant.kSecondaryColor.withOpacity(0.8),

      ),
  );

}