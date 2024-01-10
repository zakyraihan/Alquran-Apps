import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_alquran/data/api/quran_service.dart';
import 'package:my_alquran/data/preferences/preferences_helper.dart';
import 'package:my_alquran/provider/audio_notifier.dart';
import 'package:my_alquran/provider/preferences_provider.dart';
import 'package:my_alquran/provider/quran_provider.dart';
import 'package:my_alquran/ui/alquran_detail_page.dart';
import 'package:my_alquran/ui/alquran_list_page.dart';
import 'package:my_alquran/ui/doa_list_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic id = 'n';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              QuranProvider(quranService: QuranService(), id: id ?? ''),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioNotifier(),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            title: 'Flutter Demo',
            theme: provider.themeData,
            debugShowCheckedModeBanner: false,
            initialRoute: AlquranListPage.routeName,
            routes: {
              AlquranListPage.routeName: (context) => const AlquranListPage(),
              DoaListPage.routeName: (context) => const DoaListPage(),
              AlquranDetailPage.routeName: (context) {
                final args =
                    ModalRoute.of(context)?.settings.arguments as String?;
                return AlquranDetailPage(quranId: args ?? '');
              },
            },
          );
        },
      ),
    );
  }
}
