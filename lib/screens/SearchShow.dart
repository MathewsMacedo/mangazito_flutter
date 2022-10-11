import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchShow extends StatefulWidget {
  SearchShow({Key? key, required this.search}) : super(key: key);
  final String search;
  @override
  State<SearchShow> createState() => _SearchShowState();
}

class _SearchShowState extends State<SearchShow> {
  TextEditingController searchController = new TextEditingController();

  search(String value) async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    Navigator.pop(context, value);
  }

  @override
  void initState() {
    super.initState();
    searchController.text = widget.search;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Center(
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Text("Pesquisa:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700))),
        ),
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Digite sua busca",
            hintText: "Pesquisa",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        SizedBox(
          width: 150,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () async {
                search(searchController.text);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
              child: const Text(
                "Buscar...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
