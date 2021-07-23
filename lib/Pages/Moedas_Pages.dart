import 'package:criptomoeda/Repositorios/Repositorios.dart';
import 'package:flutter/material.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  @override
  Widget build(BuildContext context) {
    final tabela = MoedasRepositorio.tabela;

    return Scaffold(
      appBar: AppBar(
        title: Text("Criptomoedas"),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, moeda){
            return ListTile(
              leading: Image.asset(tabela[moeda].icone),
              title: Text(tabela[moeda].nome),
              trailing: Text(tabela[moeda].preco.toString()),
            );
          },
          separatorBuilder: (__,___) => Divider(),
          itemCount: tabela.length)
    );
  }
}
