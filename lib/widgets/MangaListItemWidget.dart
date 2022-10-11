import 'package:flutter/material.dart';
import 'package:manga_app/utils/constants.dart';
import 'package:manga_app/widgets/LabelFinishedWidget.dart';

import '../utils/title.dart';

class MangaListItemWidget extends StatelessWidget {
  const MangaListItemWidget(
      {required this.photo,
      required this.title,
      required this.categories,
      required this.lang,
      required this.finish,
      required this.onTap,
      Key? key});

  final String photo;
  final String title;
  final String categories;
  final String lang;
  final bool finish;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.05,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleHeader(title),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          showCategory(categories),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black26),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              lang,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black26),
                            ),
                            LabelFinishedWidget(
                                finish: finish, width: 90, fontSize: 14)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String showCategory(String categories) {
    List<String> all = categories.split(" | ");
    if (all.length > 2) {
      categories = "${all[0]} | ${all[1]} | ...";
    }
    return categories;
  }
}
