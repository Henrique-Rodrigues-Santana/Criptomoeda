import 'package:criptomoeda/Configs/app_settings.dart';
import 'package:criptomoeda/Repositorios/Favoritas_Repositorios.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Configs/Hive_Config.dart';
import 'Meu_Aplicativo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppSettings(),

          ),

          ChangeNotifierProvider(
            create: (context) => FavoritasRepositorios(),

          )

        ],
        child: MeuApp(),
      )
  );


}


