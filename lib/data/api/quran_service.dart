import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_alquran/data/model/alquran_model.dart';
import 'package:my_alquran/data/model/detail_model.dart';
import 'package:my_alquran/data/model/doa_model.dart';

class QuranService {
  static const _baseUrl = 'https://equran.id/api/v2/surat';

  Future<AlquranResult> fetchDataQuran() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return AlquranResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to fetch data');
    }
  }

  Future<AlquranDetail> getAlquranDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('API Response: $data');
      return alquranDetailFromJson(data);
    } else {
      print('Error Response: ${response.body}');
      throw Exception('Failed to load detail alquran');
    }
  }

  Future getDoaHarian() async {
    final response = await http
        .get(Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api'));
    if (response.statusCode == 200) {
      return doaFromJson(response.body);
    } else {
      throw Exception('Failed to load Doa');
    }
  }
}
