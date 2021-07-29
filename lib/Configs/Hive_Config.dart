import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveConfig{
  static start() async{
    // acessar o diretorio onde os documentos desse aplicativos vão ficar localizados
    Directory dir = await getApplicationDocumentsDirectory();
    // localização onde queremos salvar os arquivos
    await Hive.initFlutter(dir.path);
  }
}