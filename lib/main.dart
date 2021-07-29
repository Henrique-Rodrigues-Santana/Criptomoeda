import 'package:criptomoeda/Repositorios/Favoritas_Repositorios.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Meu_Aplicativo.dart';

void main(){
  runApp(
      ChangeNotifierProvider(
        create: (context) => FavoritasRepositorios(),
        child: MeuApp(),
      )
  );


}


