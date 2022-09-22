import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practice/metadata/district_model.dart';
import 'package:practice/metadata/dropdown_json_data.dart';
import 'package:practice/metadata/province_model.dart';

class DropDownProvider with ChangeNotifier{
  List<ProvinceModel> provinceList=[];
  List<DistrictModel> districtList=[];
  bool isLoading=true;
  DropDownProvider(){
    fetchData();
  }

  void fetchData(){
    var jsonData=json.decode(dropdownJsonData);
    for(int i=0;i<jsonData["data"].length;i++){
      var provinceJson=jsonData["data"][i];
      ProvinceModel provinceModel=ProvinceModel.fromMap(provinceJson);
      provinceList.add(provinceModel);
      for(var singleDistrict in provinceJson["Districts"]){
        districtList.add(DistrictModel.fromMap(singleDistrict, provinceModel.id));
      }
    }
    isLoading=false;
    notifyListeners();
  }
}

