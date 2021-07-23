import 'package:criptomoeda/Model/Moeda.dart';
import 'package:criptomoeda/Repositorios/Repositorios.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  
  final tabela = MoedasRepositorio.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_br',name: 'R\$');
  List<Moeda> selecionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criptomoedas"),
        ),
        body: ListView.separated(
            padding: EdgeInsets.all(16),
            itemBuilder: (context, moeda) {
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                leading:(selecionadas.contains(tabela[moeda]))
                ? CircleAvatar(
                  child: Icon(Icons.check),
                )
                : SizedBox(
                  child: Image.asset(tabela[moeda].icone),
                  width: 40,
                ),
                title: Text(
                  tabela[moeda].nome,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                trailing: Text(real.format(tabela[moeda].preco)),
                selected: selecionadas.contains(tabela[moeda]),
                selectedTileColor: Colors.indigo[50],
                onLongPress: (){
                  setState(() {
                    (selecionadas.contains(tabela[moeda])
                        ? selecionadas.remove(tabela[moeda])
                        : selecionadas.add(tabela[moeda])
                    );
                  });
                },
              );
            },
            separatorBuilder: (__, ___) => Divider(),
            itemCount: tabela.length));
  }
}
