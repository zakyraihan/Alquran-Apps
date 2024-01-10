// ignore_for_file: library_private_types_in_public_api

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_alquran/data/api/quran_service.dart';
import 'package:my_alquran/provider/detail_provider.dart';
import 'package:my_alquran/provider/quran_provider.dart';
import 'package:provider/provider.dart';

class AlquranDetailPage extends StatefulWidget {
  final String quranId;

  static const routeName = 'detail_page';

  const AlquranDetailPage({Key? key, required this.quranId}) : super(key: key);

  @override
  _AlquranDetailPageState createState() => _AlquranDetailPageState();
}

class _AlquranDetailPageState extends State<AlquranDetailPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  Future<void> playAudio(String audioUrl) async {
    await _audioPlayer.play(UrlSource(audioUrl));
    setState(() {
      isPlaying = true;
    });
  }

  void pauseAudio() {
    _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          DetailProvider(quranService: QuranService(), id: widget.quranId),
      child: Consumer<DetailProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ResultState.hasData) {
            var quran = provider.quranDetail.data;
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset('assets/Group 38.png'),
                        title: Text(quran.namaLatin),
                        titlePadding:
                            const EdgeInsets.only(left: 16, bottom: 16),
                      ),
                    )
                  ];
                },
                body: ListView.builder(
                  itemCount: provider.quranDetail.data.ayat.length,
                  itemBuilder: (context, index) {
                    final ayat = quran.ayat[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${ayat.nomorAyat}')),
                      title: Text(ayat.teksArab),
                      trailing: Column(
                        children: [
                          if (ayat.audio.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                              ),
                              onPressed: () {
                                if (isPlaying) {
                                  pauseAudio();
                                } else {
                                  playAudio(ayat.audio.toString());
                                }
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (provider.state == ResultState.noData ||
              provider.state == ResultState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/error.webp',
                    height: 200,
                  ),
                  const Gap(5),
                  Text('Terjadi Kesalahan',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
