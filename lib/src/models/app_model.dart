import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  late bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    if (loading == false) {
      Future.delayed(const Duration(seconds: 1), () => _setLoading(false));
    } else {
      Future.delayed(Duration.zero, () => _setLoading(true));
    }
  }

  _setLoading(bool loading) {
    _isLoading = loading;

    notifyListeners();
  }
}
