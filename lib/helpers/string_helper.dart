extension StringUtils on String {
  String get nameCase {
    final f = substring(0, 1).toUpperCase();
    final d = substring(1).toLowerCase();
    return f + d;
  }
}
