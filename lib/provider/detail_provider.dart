import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_alquran/data/api/quran_service.dart';
import 'package:my_alquran/data/model/detail_model.dart';
import 'package:my_alquran/provider/quran_provider.dart';

class DetailProvider extends ChangeNotifier {
  final QuranService quranService;
  final String id;

  DetailProvider({required this.quranService, required this.id}) {
    _getQuranDetail();
  }

  late AlquranDetail _quranResult;
  late ResultState _state;
  String _message = '';

  AlquranDetail get quranDetail => _quranResult;
  ResultState get state => _state;
  String get message => _message;

  Future<void> _getQuranDetail() async {
    try {
      _state = ResultState.loading;
      final quranDetail = await quranService.getAlquranDetail(id);
      _state = ResultState.hasData;
      _quranResult = quranDetail;
    } catch (e) {
      _state = ResultState.error;
      log('message error: ' + e.toString());
      _message = 'An error occurred: $e';
    } finally {
      notifyListeners();
    }
  }
}
