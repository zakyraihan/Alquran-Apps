import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../common/style.dart';

class DoaCardWidget extends StatefulWidget {
  const DoaCardWidget({
    super.key,
    required this.id,
    required this.doa,
    required this.ayat,
    required this.isLatin,
    required this.arti,
    required this.latin,
  });

  final String id;
  final String doa;
  final String ayat;
  final String arti;
  final bool isLatin;
  final String latin;

  @override
  State<DoaCardWidget> createState() => _DoaCardWidgetState();
}

class _DoaCardWidgetState extends State<DoaCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              leading: CircleAvatar(child: Text(widget.id)),
              title: Text(widget.doa),
            ),
            const Gap(10),
            widget.isLatin
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(widget.latin, style: style(fs: 20)),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(widget.ayat, style: style(fs: 20)),
                  ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.arti),
            )
          ],
        ),
      ),
    );
  }
}
