int compareMetroLineNames(String a, String b) {
  // Expression régulière pour extraire la partie numérique et la partie lettres
  final regex = RegExp(r'^(\d+)([A-Za-z]*)$');

  final matchA = regex.firstMatch(a);
  final matchB = regex.firstMatch(b);

  if (matchA != null && matchB != null) {
    final numA = int.parse(matchA.group(1)!);
    final numB = int.parse(matchB.group(1)!);

    // Si les numéros sont différents -> tri numérique
    if (numA != numB) return numA.compareTo(numB);

    // Sinon -> tri du suffixe (par ex. "7B" après "7")
    final suffixA = matchA.group(2)!;
    final suffixB = matchB.group(2)!;
    return suffixA.compareTo(suffixB);
  }

  // Si un des deux ne correspond pas au format numérique
  return a.compareTo(b);
}
