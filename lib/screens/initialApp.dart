import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/screens/createAccount.dart';
import '../../utils/showPageFromBottom.dart';
import '../../widgets/ElevatedBottomButtonWidget.dart';
import '../utils/constants.dart';
import '../widgets/HomeItemWidget.dart';
import 'login.dart';

class InitialApp extends StatefulWidget {
  const InitialApp({Key? key}) : super(key: key);

  final List<Widget> items = const [
    HomeItemWidget(
        photo:
            "https://64.media.tumblr.com/64d62e4d16b9ea01b6f71bcd54ebdd85/9dc1bb34e2dd12fb-8b/s1280x1920/b0b726163ed1b46a744b2e29c93f4da133fa43f8.png",
        title: "Mangas na palma da sua mão 📱 🥳",
        subtitle: "Todos os lançamentos e mangas favoritos!"),
    HomeItemWidget(
        photo: "https://download.medibang.com/contest/3rdjumpillust/img1.png",
        title: "Rápido e fácil ✅ 😎",
        subtitle: "Leia de qualquer lugar e aonde você quiser com Mangazito"),
    HomeItemWidget(
        photo:
            "https://64.media.tumblr.com/c2c46ee1b4f79b258bb6b7ad40994974/6ab0e4c98814deb1-bb/s540x810/18a5bdbcd7a4551c89959836c95264536da4f241.pnj",
        title: "Crie sua conta 🥰 😍",
        subtitle:
            "Crie sua conta e seu perfil, se divirta e compartilhe com seus amigos!")
  ];

  @override
  State<InitialApp> createState() => _InitialAppPageState();
}

class _InitialAppPageState extends State<InitialApp> {
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CarouselSlider(
        items: widget.items,
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1,
          onPageChanged: (page, reason) {
            setState(() {
              _activePage = page;
            });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ElevatedBottomButtonWidget(
            name: "CRIAR UMA CONTA",
            onPressed: () {
              showPageFromBottom(context, Account(), 0.95).then((e) {});
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Já possui cadastro? ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.justify,
                ),
                InkWell(
                  child: const Text(
                    "Acesse aqui.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  onTap: () {
                    showPageFromBottom(context, Login(), 0.60).then((e) {});
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(
              widget.items.length,
              _activePage,
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> indicators(length, currentIndex) {
    return List<Widget>.generate(length, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 7,
        height: 7,
        decoration: BoxDecoration(
            color: currentIndex == index
                ? Colors.black
                : Color.fromARGB(60, 173, 173, 173),
            shape: BoxShape.circle),
      );
    });
  }
}
