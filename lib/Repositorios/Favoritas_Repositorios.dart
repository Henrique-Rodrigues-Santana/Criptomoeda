import 'dart:collection';

import 'package:criptomoeda/Adapters/Moeda_Hive_Adapter.dart';
import 'package:flutter/material.dart';
import 'package:criptomoeda/Model/Moeda.dart';
import 'package:hive/hive.dart';


class FavoritasRepositorios extends ChangeNotifier{
  List<Moeda> _lista = [];
  late LazyBox box;


  FavoritasRepositorios(){
    _startRepositorio();
  }

  _startRepositorio()async{
    await _openBox();
    await _readFavoritas();
  }

  _openBox()async{
    Hive.registerAdapter(MoedaHiveAdapter());
        box = await Hive.openLazyBox<Moeda>('moedas_favoritas');
  }

  _readFavoritas(){
    box.keys.forEach((moeda)async {
      Moeda m = await box.get(moeda);
      _lista.add(m);
      notifyListeners();
    });
  }


  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);

  safAll(List<Moeda> moedas){
    moedas.forEach((moeda) {
      if(!_lista.any((atual) => atual.sigla == moeda.sigla)){
        _lista.add(moeda);
        box.put(moeda.sigla, moeda);
      }
    });
    notifyListeners();
  }
  remove(Moeda moeda){
    _lista.remove(moeda);
    box.delete(moeda.sigla);
    notifyListeners();
 }
}