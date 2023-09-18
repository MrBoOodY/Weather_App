class RouteStrings {
  static RouteStrings? _instance;

  RouteStrings._();
  static RouteStrings get instance {
    _instance ??= RouteStrings._();
    return _instance!;
  }

  final String initial = '/';
}
