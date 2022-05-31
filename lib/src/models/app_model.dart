import 'dart:ffi';

import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;

    notifyListeners();
  }
}
