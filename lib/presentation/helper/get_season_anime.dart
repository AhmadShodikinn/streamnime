int getAnimeSeason(String title) {
  title = title.trim();

  final regex = RegExp(r'season\s*(\d+)', caseSensitive: false);
  final match = regex.firstMatch(title);

  if (match != null) {
    return int.parse(match.group(1)!);
  }

  return 1;
}
