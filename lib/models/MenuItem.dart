class MenutItem {
  int total;
  String name;

  MenutItem({required this.total, required this.name});

  MenutItem.fromJson(Map json)
      : total = json['titles'],
        name = json['name'];
}
