extension DoubleExtensions on double? {
  String toTemperature(bool isCelsius) {
    if (this == null) {
      return 'N/A';
    } else {
      return this!.round().toString() + (isCelsius ? '\u2103' : '\u2109');
    }
  }
}
