import 'package:flutter/material.dart';
import 'package:my_alquran/data/api/quran_service.dart';
import 'package:my_alquran/data/model/alquran_model.dart';

enum ResultState { loading, noData, hasData, error }

class QuranProvider extends ChangeNotifier {
  final QuranService quranService;
  final String id;

  QuranProvider({required this.quranService, required this.id}) {
    fetchQuranSurah();
  }

  late AlquranResult _alquranResult;
  late ResultState _state;
  String _message = '';

  AlquranResult get alquranResult => _alquranResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchQuranSurah() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final quranSurah = await quranService.fetchDataQuran();
      if (quranSurah.data.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _alquranResult = quranSurah;
      }
    } catch (e) {
      _state = ResultState.error;
      print(e);
      notifyListeners();
      return _message = 'Error -> $e';
    } finally {
      notifyListeners();
    }
  }
}
