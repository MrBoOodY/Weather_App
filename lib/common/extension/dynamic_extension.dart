extension DynamicExtension on dynamic {
  dynamic get putNAIfNull {
    if (this == null) {
      return 'N/A';
    } else {
      return this;
    }
  }
}
