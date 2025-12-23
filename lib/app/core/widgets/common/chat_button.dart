import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../constants/colors.dart';

Widget chatButton() {
  return FloatingActionButton(
    onPressed: () => launchUrl(Uri.parse(Config.whatsappLink)),
    backgroundColor: mainColor,
    child: const Icon(
      Icons.chat,
      color: Colors.white,
    ),
  );
}
