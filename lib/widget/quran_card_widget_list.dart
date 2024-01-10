import 'package:flutter/material.dart';

import '../common/style.dart';

class QuranCardListWidget extends StatelessWidget {
  const QuranCardListWidget({
    super.key,
    required this.nama,
    required this.namaLatin,
    required this.nomor,
    required this.arti,
    this.onTap,
  });

  final String nama;
  final String namaLatin;
  final String nomor;
  final String arti;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(nama, style: style(fs: 23, fw: FontWeight.w600)),
        subtitle:
            Text(namaLatin, style: const TextStyle(color: Color(0xFFA19CC5))),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: const AssetImage('assets/nomor_border.png'),
          child: Text(nomor),
        ),
        trailing: Text(arti.toString(),
            style: const TextStyle(color: Color(0xFFA19CC5))),
        onTap: onTap,
      ),
    );
  }
}
