import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_alquran/provider/preferences_provider.dart';
import 'package:my_alquran/provider/quran_provider.dart';
import 'package:my_alquran/widget/quran_card_widget_list.dart';
import 'package:provider/provider.dart';

import 'alquran_detail_page.dart';
import 'doa_list_page.dart';

class AlquranListPage extends StatefulWidget {
  const AlquranListPage({super.key});

  static const routeName = 'list_page';

  @override
  State<AlquranListPage> createState() => _AlquranListPageState();
}

class _AlquranListPageState extends State<AlquranListPage> {
  int currentIndex = 0;

  void route(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Group 38.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Theme'),
                trailing: Consumer<PreferencesProvider>(
                  builder: (context, provider, child) {
                    return Switch.adaptive(
                      thumbIcon: MaterialStatePropertyAll(
                        provider.isDarkTheme
                            ? const Icon(Icons.dark_mode_outlined)
                            : const Icon(Icons.light_mode_outlined),
                      ),
                      value: provider.isDarkTheme,
                      onChanged: (value) {
                        provider.enableDarkTheme(value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text('Holy Quran'),
      ),
      body: _buildList(context),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon((Icons.change_circle)),
              label: 'Doa harian',
              onTap: () => navigator.push(MaterialPageRoute(
                  builder: (context) => const DoaListPage()))),
        ],
      ),
    );
  }

  Future<void> _fetchQuran() async {
    await context.read<QuranProvider>().fetchQuranSurah();
  }

  Widget _buildList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchQuran,
      child: Consumer<QuranProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state != ResultState.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/error.webp',
                  height: 200,
                ),
                const Gap(5),
                Text(
                  'Terjadi Kesalahan',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: _fetchQuran, // Use the _fetchQuran function here
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        } else {
          // ignore: curly_braces_in_flow_control_structures
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListView.builder(
              itemCount: state.alquranResult.data.length,
              itemBuilder: (context, index) {
                var quran = state.alquranResult.data[index];
                return QuranCardListWidget(
                  nama: quran.nama,
                  namaLatin: quran.namaLatin,
                  nomor: quran.nomor.toString(),
                  arti: quran.arti.toString(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AlquranDetailPage(quranId: quran.nomor.toString()),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
