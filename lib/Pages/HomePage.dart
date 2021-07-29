import 'package:criptomoeda/Pages/FavoritasPage.dart';
import 'package:criptomoeda/Pages/Moedas_Pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;


  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina){
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          MoedasPage(),
          FavoritasPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todos"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritos")
        ],

        onTap: (pagina){
          pc.animateToPage(
              pagina,
              duration: Duration(milliseconds: 400),
              curve: Curves.decelerate);
        },

      ),
    );
  }
}
