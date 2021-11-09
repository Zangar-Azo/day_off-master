String interpretPrice(String price) {
  var parts = price.split('.');
  parts[0] = parts[0].replaceAll(RegExp(r'\D'), '');
  parts[0] = parts[0].replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ' ');
  return parts[0];
}
