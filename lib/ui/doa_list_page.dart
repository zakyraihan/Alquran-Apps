import 'package:flutter/material.dart';
import 'package:my_alquran/data/api/quran_service.dart';
import 'package:my_alquran/widget/doa_card_widget.dart';

import '../data/model/doa_model.dart';

class DoaListPage extends StatefulWidget {
  const DoaListPage({super.key});

  static const routeName = 'doa_harian';

  @override
  State<DoaListPage> createState() => _DoaListPageState();
}

class _DoaListPageState extends State<DoaListPage> {
  late Future data;
  List<Doa> doa = [];

  @override
  void initState() {
    data = QuranService().getDoaHarian();
    data.then((value) {
      setState(() {
        doa = value;
      });
    });
    super.initState();
  }

  bool isLatin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doa Harian'),
        actions: const [],
      ),
      body: doa.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: doa.length,
              itemBuilder: (context, index) {
                final data = doa[index];
                return DoaCardWidget(
                  id: data.id,
                  doa: data.doa,
                  ayat: data.ayat,
                  isLatin: isLatin,
                  arti: data.artinya,
                  latin: data.latin,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLatin = !isLatin;
          });
        },
        child: const Text('Latin'),
      ),
    );
  }
}
