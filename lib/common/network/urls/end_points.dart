class EndPoints {
  static EndPoints? _instance;
  // Avoid self instance
  EndPoints._();
  static EndPoints get instance {
    _instance ??= EndPoints._();
    return _instance!;
  }

  //* ////////////////// <Home> ///////////////////////
  final String currentWeatherData = '/forecast.json';
}
