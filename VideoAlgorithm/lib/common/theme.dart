import 'package:flutter/material.dart';
import 'package:video_algorithm/common/color.dart';

class CustomTheme{
  CustomTheme._();
  static InputDecoration getDecorationWithLabel(String label){
    return  InputDecoration(

        alignLabelWithHint: true,
        label: Text(
            label,
          style: TextStyle(
            color: ColorConstant.kSecondaryColor,
            fontWeight: FontWeight.bold
          ),
        ),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color:ColorConstant.kSecondaryColor,width: 1)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: ColorConstant.kSecondaryColor,width: 1)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: ColorConstant.kSecondaryColor,width: 1)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: ColorConstant.kSecondaryColor,width: 1)
        )
    );
  }
}