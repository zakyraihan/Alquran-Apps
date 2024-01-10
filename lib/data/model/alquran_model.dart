// To parse this JSON data, do
//
//     final alquranResult = alquranResultFromJson(jsonString);

import 'dart:convert';

AlquranResult alquranResultFromJson(String str) =>
    AlquranResult.fromJson(json.decode(str));

String alquranResultToJson(AlquranResult data) => json.encode(data.toJson());

class AlquranResult {
  int? code;
  String? message;
  List<Quran> data;

  AlquranResult({
    this.code,
    this.message,
    required this.data,
  });

  factory AlquranResult.fromJson(Map<String, dynamic> json) => AlquranResult(
        code: json["code"],
        message: json["message"],
        data: List<Quran>.from(json["data"].map((x) => Quran.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Quran {
  int nomor;
  String nama;
  String namaLatin;
  int? jumlahAyat;
  TempatTurun? tempatTurun;
  String? arti;
  String? deskripsi;
  Map<dynamic, dynamic> audioFull;

  Quran({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
  });

  factory Quran.fromJson(Map<String, dynamic> json) => Quran(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: tempatTurunValues.map[json["tempatTurun"]]!,
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map.from(json["audioFull"])
            .map((k, v) => MapEntry<dynamic, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurunValues.reverse[tempatTurun],
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull":
            Map.from(audioFull).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class AudioFull {
  final String reciter;
  final String url;

  AudioFull({
    required this.reciter,
    required this.url,
  });

  factory AudioFull.fromJson(Map<String, dynamic> json) {
    return AudioFull(
      reciter: json['reciter'],
      url: json['url'],
    );
  }
}

enum TempatTurun { MADINAH, MEKAH }

final tempatTurunValues =
    EnumValues({"Madinah": TempatTurun.MADINAH, "Mekah": TempatTurun.MEKAH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
