
import 'package:criptomoeda/Configs/app_settings.dart';
import 'package:criptomoeda/Model/Moeda.dart';
import 'package:criptomoeda/Pages/Moedas_Detalhes_Page.dart';
import 'package:criptomoeda/Repositorios/Favoritas_Repositorios.dart';
import 'package:criptomoeda/Repositorios/Repositorios.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  
  final tabela = MoedasRepositorio.tabela;
  late NumberFormat real ;
  late Map<String,String> loc;
  List<Moeda> selecionadas = [];
  late FavoritasRepositorios favoritas;

  readNumberFormat(){
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'],name: loc['name']);
  }

  changeLanguageButton(){
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] ==  'pt_BR' ? '\$' :  'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.swap_vert_circle),
              title: Text('Usar $locale'),
              onTap: () {
               context.read<AppSettings>().setLocale(locale,name);
              },
            ))
      ] ,
    );

  }

  limparSelecionadas(){
    setState(() {
      selecionadas = [];
    });
  }

  AppBarDinamica(){
    if(selecionadas.isEmpty){
      return AppBar(
        title: Text("Criptomoedas"),
        actions: [
          changeLanguageButton()
        ],
      );
    }else{
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text("${selecionadas.length} Selecionadas"),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20
          )
        ),
      );
    }
  }

  // aqui passamos como parametro a moeda selecionada
  mostrarDetalhes(Moeda moeda){

    Navigator.push(context, MaterialPageRoute(
        // aqui indicamos a pagina e passamos como parametro para a proxima o valor escolhido
        // no caso "moeda" que definimos
        builder:(_)=>MoedasDetalhePage(moeda: moeda) )
    );

  }

  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    favoritas = Provider.of<FavoritasRepositorios>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
          onPressed: (){
            favoritas.safAll(selecionadas);
            limparSelecionadas();
          },
          label: Text("favoritar",style: TextStyle(
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
          ),
          ),
        icon: Icon(Icons.star),
      )
          : null,
        appBar: AppBarDinamica(),
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
                title: Row(
                  children: [
                    Text(
                      tabela[moeda].nome,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    if(favoritas.lista.any((fav) => fav.sigla == tabela[moeda].sigla))
                      Icon(Icons.circle,color: Colors.amber, size: 8,)
                  ],
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
                onTap: () => mostrarDetalhes(tabela[moeda]),
              );
            },
            separatorBuilder: (__, ___) => Divider(),
            itemCount: tabela.length));

  }
}
