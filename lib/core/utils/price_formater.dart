class CustomPriceFormatter {
  static String formatInteger(int number) {
    // Convert the integer to a string
    String numStr = number.toString();

    // Reverse the string to easily insert commas every three characters
    String reversedStr = numStr.split('').reversed.join();

    // Insert commas every three characters
    String formattedStr = '';
    for (int i = 0; i < reversedStr.length; i++) {
      if (i > 0 && i % 3 == 0) {
        formattedStr += ',';
      }
      formattedStr += reversedStr[i];
    }

    // Reverse the string back to the original order
    formattedStr = formattedStr.split('').reversed.join();

    // Add the currency symbol
    return '₦$formattedStr';
  }
}
