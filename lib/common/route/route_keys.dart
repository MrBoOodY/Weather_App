class RouteKeys {
  static RouteKeys? _instance;
  // Avoid self instance
  RouteKeys._();
  static RouteKeys get instance {
    _instance ??= RouteKeys._();
    return _instance!;
  }
}
