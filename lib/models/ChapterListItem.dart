class ChapterListItem {
  int id;
  int idLink;
  String name;
  String title;

  ChapterListItem(
      {required this.id,
      required this.name,
      required this.title,
      required this.idLink});

  ChapterListItem.fromJson(dynamic json)
      : id = json['id_chapter'],
        idLink =
            json['releases'][json['releases'].keys.toList()[0]]['id_release'],
        name = json['number'],
        title = json['chapter_name'] == ""
            ? "Chapter #${json['number']}"
            : json["chapter_name"];
}
