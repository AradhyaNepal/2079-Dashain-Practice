class ProvinceModel{
  static const idName="id",nameName="name";
  int id;
  String name;
  ProvinceModel({
    required this.id,
    required this.name
  });

  factory ProvinceModel.fromMap(Map map){
    return ProvinceModel(
        id: map[idName],
        name: map[nameName]
    );
  }
}