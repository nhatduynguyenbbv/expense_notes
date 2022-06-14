import 'package:flutter_bloc/flutter_bloc.dart';

class AppModel extends Cubit<bool> {
  late bool _isLoading = false;

  AppModel(bool initialState) : super(initialState);

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

    emit(isLoading);
  }
}
