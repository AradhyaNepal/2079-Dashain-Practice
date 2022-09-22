class PhotoModel{
  static const albumIdName="albumId",idName="id",titleName="title",urlName="url",thumbnailUrlName="thumbnailUrl";
  int albumId,id;
  String title,url,thumbnailUrl;
  PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl
  });

  factory PhotoModel.fromMap(Map serverData){
    return PhotoModel(
        albumId: serverData[albumIdName],
        id:  serverData[idName],
        title: serverData[titleName],
        url: serverData[urlName],
        thumbnailUrl: serverData[thumbnailUrlName]
    );
  }

  Map getMap(){
    return {
      albumIdName:albumId,
      idName:id,
      titleName:title,
      urlName:url,
      thumbnailUrlName:thumbnailUrl,


    };
  }
}

// {
// "albumId": 1,
// "id": 1,
// "title": "accusamus beatae ad facilis cum similique qui sunt",
// "url": "https://via.placeholder.com/600/92c952",
// "thumbnailUrl": "https://via.placeholder.com/150/92c952"
// },