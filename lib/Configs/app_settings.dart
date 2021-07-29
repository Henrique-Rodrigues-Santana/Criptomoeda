import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier{
  // instancia para acessar o sistema interno de arquivos
  //late SharedPreferences _prefs;

  // uma caia onde vamos colocar o tipo chave/valor
  late Box box;

  // localização do app
  Map<String, String> locale = {
      'locale':'pt_BR',
      'name' : 'R\$',

  };

  AppSettings(){
    _startSettings();
  }

  _startSettings()async{
    await _startPreferences();
    await _readLocale();
  }
  // inicializando as preferencias
  Future<void> _startPreferences()async{
    // inicializando o sistema de arquivos
    //_prefs = await SharedPreferences.getInstance();

    box = await Hive.openBox('preferencias');

  }
  // ler as preferencias
  _readLocale(){
    // metodo Provider
    // final local = _prefs.getString('local') ?? 'pt_BR';
    // final name = _prefs.getString('name') ?? 'R\$';

    // metodo Hive
    final local = box.get('local') ?? 'pt_BR';
    final name = box.get('name') ?? 'R\$';
    locale = {
      'locale':local,
      'name': name
    };
    // e notificar os Listeners
    notifyListeners();

    // metodo pblico para que qualquer classe possa alterar o locale


  }
  setLocale(String local, String name) async {
    // Metodo Provider
    // await _prefs.setString('local', local);
    // await _prefs.setString('name', name);

    // Metodo Hive
    await box.put('local', local);
    await box.put('name', name);

    // para atualizar o locale
    await _readLocale();
  }
}