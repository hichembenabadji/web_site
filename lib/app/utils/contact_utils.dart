import 'package:mysite/changes/links.dart';

class ContactUtils {
  final String name;
  final String url;
  final String icon;

  const ContactUtils({
    required this.name,
    required this.url,
    required this.icon,
  });
}

/// Social networks, displayed from left to right in this exact order.
const List<ContactUtils> contactUtils = [
  ContactUtils(
    name: 'LinkedIn',
    url: linkedin,
    icon: 'https://img.icons8.com/ios-filled/50/000000/linkedin.png',
  ),
  ContactUtils(
    name: 'GitHub',
    url: gitHub,
    icon: 'https://img.icons8.com/ios-glyphs/60/000000/github.png',
  ),
  ContactUtils(
    name: 'Google Play Store',
    url: playstore,
    icon: 'https://img.icons8.com/?size=64&id=100006&format.png',
  ),
  ContactUtils(
    name: 'YouTube',
    url: youtube,
    icon: 'https://img.icons8.com/ios-filled/50/000000/youtube-play.png',
  ),
  ContactUtils(
    name: 'X (Twitter)',
    url: twitter,
    icon: 'https://img.icons8.com/fluency/48/000000/twitter.png',
  ),
  ContactUtils(
    name: 'TikTok',
    url: tiktok,
    icon: 'https://img.icons8.com/?size=64&id=118638&format.png',
  ),
  ContactUtils(
    name: 'Instagram',
    url: instagram,
    icon: 'https://img.icons8.com/glyph-neue/64/000000/instagram-new.png',
  ),
];
