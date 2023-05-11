String toTitle(String word) {
  return word[0].toUpperCase() + word.substring(1);
}

String dashedBetween(String word, int characters) {
  String specialCharacter = "";
  for (int i = 0; i < word.length; i++) {
    if (i + 1 > characters && i % characters == 0) {
      specialCharacter += "-";
    }

    specialCharacter += word[i];
  }

  return specialCharacter;
}
