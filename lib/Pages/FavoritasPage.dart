import 'package:criptomoeda/Model/Moeda.dart';
import 'package:criptomoeda/Pages/Moedas_Detalhes_Page.dart';
import 'package:criptomoeda/Repositorios/Favoritas_Repositorios.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class FavoritasPage extends StatefulWidget {
  const FavoritasPage({Key? key}) : super(key: key);

  @override
  _FavoritasPageState createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moedas Favoritas"),
      ),
      body: Container(
          color: Colors.indigo.withOpacity(0.05),
          height: MediaQuery
              .of(context)
              .size
              .height,
          padding: EdgeInsets.all(12),
          child: Consumer<FavoritasRepositorios>(
              builder: (context, favoritas, child) {
                return favoritas.lista.isEmpty
                    ? ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Ainda não há moedas favoritas"),
                )
                    : ListView.builder(
                    itemCount: favoritas.lista.length,
                    itemBuilder: (_, index){
                      return MoedaCard( moeda: favoritas.lista[index]);
                    }
                );
              }
          )
      ),
    );
  }
}

class MoedaCard extends StatefulWidget {
  Moeda moeda;

   MoedaCard({Key? key, required this.moeda}) : super(key: key);

  @override
  _MoedaCardState createState() => _MoedaCardState();
}

class _MoedaCardState extends State<MoedaCard> {

  NumberFormat real = NumberFormat.currency(locale: "pt_BR", name: "R\$");

  static Map<String, Color> precoColor = <String, Color>{
    'up': Colors.teal,
    'down' : Colors.indigo,
  };

  abrirDetalhes(){
    Navigator.push(context,MaterialPageRoute(
      builder: (_) => MoedasDetalhePage(moeda: widget.moeda)
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => abrirDetalhes() ,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20,top: 20,left: 20),
          child: Row(
            children: [
              Image.asset(widget.moeda.icone,height: 40,),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.moeda.nome,style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                        ),
                        Text(
                          widget.moeda.sigla,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black
                          ),
                        )
                      ],
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                decoration: BoxDecoration(
                  color: precoColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: precoColor['down']!.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(100),

                ),
                child: Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                    fontSize: 16,
                    color: precoColor['down'],
                    letterSpacing: -1
                  ),
                ),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: ListTile(
                          title: Text("Remover das Favoritas"),
                          onTap: (){
                            Navigator.pop(context);
                            Provider.of<FavoritasRepositorios>(context, listen: false)
                                .remove(widget.moeda);
                          },
                        )
                    )
                  ]

              )
            ],
          ),
        ),
      ),

    );
  }
}

