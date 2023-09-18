import 'package:location/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(LocationServiceRef ref) {
  return LocationServiceImpl(Location());
}

abstract class LocationService {
  Future<bool> serviceEnabled();
  Future<bool> requestService();
  Future<PermissionStatus> hasPermission();
  Future<PermissionStatus> requestPermission();
  Future<LocationData> getLocation();
}

class LocationServiceImpl implements LocationService {
  final Location location;

  LocationServiceImpl(this.location);

  @override
  Future<bool> serviceEnabled() => location.serviceEnabled();

  @override
  Future<PermissionStatus> hasPermission() => location.hasPermission();
  @override
  Future<PermissionStatus> requestPermission() => location.requestPermission();

  @override
  Future<LocationData> getLocation() => location.getLocation();

  @override
  Future<bool> requestService() => location.requestService();
}

@riverpod
Future<LocationData?> determinePosition(DeterminePositionRef ref) async {
  try {
    final serviceController = ref.read(locationServiceProvider);
    bool serviceEnabled = await serviceController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await serviceController.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    PermissionStatus permissionGranted =
        await serviceController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await serviceController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await serviceController.getLocation();
  } catch (error) {
    rethrow;
  }
}
