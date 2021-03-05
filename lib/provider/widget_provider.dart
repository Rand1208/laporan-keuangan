import 'package:flutter/material.dart';

class WidgetProvider with ChangeNotifier {
  int _status = 0;

  int get status => _status;
  set status(int value) {
    _status = value;
    notifyListeners();
  }
}

class StatusA with ChangeNotifier {
  String _warnaa = "#f1faee";
  String _warnab = "#f1faee";
  String _warnac = "#f1faee";
  String _warnad = "#f1faee";
  String _warnae = "#f1faee";
  String _warnaf = "#f1faee";
  String _warnag = "#f1faee";
  String _warnah = "#f1faee";

  String get warnaa => _warnaa;
  set warnaa(String value) {
    _warnaa = value;
    notifyListeners();
  }

  String get warnab => _warnab;
  set warnab(String value) {
    _warnab = value;
    notifyListeners();
  }

  String get warnac => _warnac;
  set warnac(String value) {
    _warnac = value;
    notifyListeners();
  }

  String get warnad => _warnad;
  set warnad(String value) {
    _warnad = value;
    notifyListeners();
  }

  String get warnae => _warnae;
  set warnae(String value) {
    _warnae = value;
    notifyListeners();
  }

  String get warnaf => _warnaf;
  set warnaf(String value) {
    _warnaf = value;
    notifyListeners();
  }

  String get warnag => _warnag;
  set warnag(String value) {
    _warnag = value;
    notifyListeners();
  }

  String get warnah => _warnah;
  set warnah(String value) {
    _warnah = value;
    notifyListeners();
  }
}
