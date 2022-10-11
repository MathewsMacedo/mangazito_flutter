class MangaListItem {
  int id;
  String photo;
  String title;
  String categories;
  String lang;
  String? description;
  double? score;
  bool? favorite;
  List<dynamic>? chaptersAll;
  List<dynamic>? imagesAll;
  bool finish;

  MangaListItem(
      {required this.id,
      required this.photo,
      required this.title,
      required this.categories,
      required this.lang,
      required this.finish,
      this.chaptersAll,
      this.imagesAll,
      this.description,
      this.favorite});

  MangaListItem.fromJson(dynamic json)
      : id = json['id_serie'],
        photo = json['cover'],
        title = json['name'],
        categories = json['categories'],
        lang = json['lang'],
        finish = json['is_complete'],
        description = json['description'],
        chaptersAll = json['chapters_all'],
        imagesAll = json['images_all'],
        score = json['score'],
        favorite = json['favorite'];
}
