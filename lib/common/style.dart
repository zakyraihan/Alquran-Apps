import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color.fromRGBO(255, 255, 255, 1);
const Color secondaryColor = Color(0xFF6B38FB);

const primary = Color(0xFF3285F3);
const white = Colors.white;
const yellow = Colors.yellow;
const deepPurple = Colors.deepPurple;
const Color darkSecondaryColor = Color(0xff64ffda);

TextStyle style({double? fs, FontWeight? fw, Color? color}) {
  return GoogleFonts.poppins(fontSize: fs, fontWeight: fw, color: color);
}

ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: deepPurple,
        onPrimary: darkSecondaryColor,
        secondary: darkSecondaryColor,
      ),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: deepPurple,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        onPrimary: secondaryColor,
        secondary: deepPurple,
      ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: deepPurple,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);


//  drawer: Drawer(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Container(
//                 height: 200,
//                 color: Colors.white,
//               ),
//               ListTile(
//                 title: const Text('Theme'),
//                 trailing: Consumer<PreferencesProvider>(
//                   builder: (context, provider, child) {
//                     return Switch.adaptive(
//                       thumbIcon: MaterialStatePropertyAll(
//                         provider.isDarkTheme
//                             ? const Icon(Icons.dark_mode_outlined)
//                             : const Icon(Icons.light_mode_outlined),
//                       ),
//                       value: provider.isDarkTheme,
//                       onChanged: (value) {
//                         provider.enableDarkTheme(value);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),