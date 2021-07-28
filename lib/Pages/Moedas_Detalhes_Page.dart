import 'package:criptomoeda/Model/Moeda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  // formatando preços
  NumberFormat real = NumberFormat.currency(locale: "pt_br", name: "R\$");
  NumberFormat moeda_usada = NumberFormat.currency(locale: "pt_br", name: "");
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0.0;

  comprar() {
    if (_form.currentState!.validate()) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Compra realizada com Sucesso")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ultilizando o metodo build para receber os dados da pagina Moedas_Page
          title: Text(widget.moeda.nome),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Image.asset(widget.moeda.icone),
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(real.format(widget.moeda.preco)),
                  ],
                ),
                (quantidade == 0.0)
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 24, top: 24),
                          alignment: Alignment.center,
                          child: Text(
                            "Digite Um Valor",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 24, top: 24),
                          alignment: Alignment.center,
                          child: Text(
                            "${moeda_usada.format(quantidade)}  ${widget.moeda.sigla}",
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                Form(
                  key: _form,
                  child: TextFormField(
                    controller: _valor,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Valor",
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      suffix: Text(
                        "Reais",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Informe o valor de compra";
                      } else if (double.parse(value) < 50) {
                        return "Compra minima é R\$50 reais";
                      } else {
                        null;
                      }
                    },
                    // enquanto digita ...
                    onChanged: (value) {
                      setState(() {
                        // quantidade vai receber o valor digitado dividido pelo valor da moeda
                        quantidade = (value.isEmpty)
                            ? 0
                            : double.parse(value) / widget.moeda.preco;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: comprar,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Comprar",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
