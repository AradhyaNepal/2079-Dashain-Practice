class DistrictModel{
  static const idName="id",nameName="name";
  int id,provinceId;
  String name;
  DistrictModel({
    required this.id,
    required this.name,
    required this.provinceId
  });

  factory DistrictModel.fromMap(Map map,int provinceId){
    return DistrictModel(
        id: map[idName],
        name: map[nameName],
        provinceId: provinceId
    );
  }
}