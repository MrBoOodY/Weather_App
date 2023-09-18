extension GetMapUtails on Map {
  String getMappedString() {
    String concatenatedString = '';
    forEach((key, value) {
      concatenatedString += value.join(',') + '\n';
    });
    return concatenatedString;
  }
}
