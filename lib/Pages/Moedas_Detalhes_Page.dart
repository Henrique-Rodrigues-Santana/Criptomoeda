import 'package:criptomoeda/Model/Moeda.dart';
import 'package:flutter/material.dart';

class MoedasDetalhePage extends StatefulWidget {
  // criei a variavel moeda
  final Moeda moeda;

                                    // adicionei a variável ao construtor da pagina
                                    // ele vai esperar para receber esse parametro de outra pagina
  const MoedasDetalhePage({Key? key, required this.moeda}) : super(key: key);

  @override
  _MoedasDetalhePageState createState() => _MoedasDetalhePageState();
}

class _MoedasDetalhePageState extends State<MoedasDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ultilizando o metodo build para receber os dados da pagina Moedas_Page
        title: Text(widget.moeda.nome),
      ),
      body: Column(
        children: [
          Text(widget.moeda.preco.toString()),
        ],
      ),
    );
  }
}
